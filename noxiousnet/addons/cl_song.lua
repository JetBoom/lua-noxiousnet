if true then return end

local INSTRUMENT_SQUAREWAVE = 0
local INSTRUMENT_SAWWAVE = 1

local Instruments = {
	[INSTRUMENT_SQUAREWAVE] = "synth/square.wav",
	[INSTRUMENT_SAWWAVE] = "synth/saw.wav"
}

local testsong = {}
testsong.Name = "Test Song"
testsong.Tracks = {
	{
		Instrument = INSTRUMENT_SQUAREWAVE,
		Volume = 1,
		Pitches = {100, 0.4, 80, 0.1, 70, 0.1, 60, 0.1, 50, 0.1, 60, 0.1, 75, 0.1, 85, 0.1, 120, 0.4}
	},
	{
		Instrument = INSTRUMENT_SAWWAVE,
		Volume = 1,
		Pitches = {50, 0.5, 100, 0.5, 150, 0.5, 200, 1}
	}
}

function NDB.SongTest()
	NDB.PlaySong(testsong, 0.2, LocalPlayer())
end

local SONGS = {}

function NDB.ExportSong(song)
	local lines = {}

	table.insert(lines, "SONGNAME "..song.Name)

	for i, track in ipairs(song.Tracks) do
		table.insert(lines, "TRACK "..i)
		table.insert(lines, "INSTRUMENT "..track.Instrument)
		table.insert(lines, "TRACKVOLUME "..track.Volume)
		table.insert(lines, "PITCHES")
		for x=1, #track.Pitches, 2 do
			table.insert(lines, track.Pitches[x].." "..track.Pitches[x + 1])
		end
		table.insert(lines, "ENDPITCHES")
		table.insert(lines, "ENDTRACK")
	end

	return table.concat(lines, "\n")
end

function NDB.ImportSong(songdata)
	local lines = string.Explode("\n", songdata)
	local song = {}
	song.Tracks = {}

	local currenttrack
	local processpitches = true
	for lineid, linedata in ipairs(lines) do
		local command, commanddata = string.match(linedata, "(.+)%s+(.+)")
		if command then
			if command == "SONGNAME" then
				song.Name = commanddata
			elseif command == "TRACK" then
				currenttrack = tonumber(commanddata)
				if currenttrack then
					song.Tracks[currenttrack] = song.Tracks[currenttrack] or {}
					song.Tracks[currenttrack].Pitches = song.Tracks[currenttrack].Pitches or {}
				end
			elseif command == "INSTRUMENT" then
				if currenttrack then
					song.Tracks[currenttrack].Instrument = tonumber(commanddata) or 0
				end
			elseif command == "TRACKVOLUME" then
				if currenttrack then
					song.Tracks[currenttrack].Volume = tonumber(commanddata) or 1
				end
			elseif command == "PITCHES" then
				processpitches = true
			elseif command == "ENDPITCHES" then
				processpitches = nil
			elseif command == "ENDTRACK" then
				currenttrack = nil
			elseif processpitches and currenttrack then
				local pitch = tonumber(command)
				local length = tonumber(commanddata)
				if pitch and length then
					local pitches = song.Tracks[currenttrack].Pitches
					if pitches then
						table.insert(pitches, pitch)
						table.insert(pitches, length)
					end
				end
			end
		end
	end

	song.Name = song.Name or "Imported Song"
	return song
end

local function StopSong(songdata)
	if songdata.SongInstruments then
		for _, instrument in pairs(songdata.SongInstruments) do
			instrument:Stop()
		end
	end

	SONGS[songdata.SoundEntity] = nil

	if table.Count(SONGS) == 0 then
		hook.Remove("Think", "SongsThink")
	end
end

local function ProcessSong(songdata)
	local volume = songdata.Volume
	local systime = SysTime()
	local finished = true
	for i, track in ipairs(songdata.Song.Tracks) do
		local trackstatus = songdata.TrackStatus[i]
		if systime >= trackstatus.NextPitchTime then
			trackstatus.CurrentSlot = trackstatus.CurrentSlot + 2
			trackstatus.CurrentPitch = track.Pitches[trackstatus.CurrentSlot] or 0
			trackstatus.NextPitchTime = systime + (track.Pitches[trackstatus.CurrentSlot + 1] or 1)
		end

		local instrument = songdata.SongInstruments[i]
		local pitch = trackstatus.CurrentPitch
		if pitch then
			finished = false
			if pitch > 0 then
				print("playing", pitch, "track", i)
				instrument:PlayEx(volume * track.Volume, pitch)
			else
				instrument:Stop()
			end
		else
			instrument:Stop()
		end
	end

	if finished then
		StopSong(songdata)
	end
end

local function SongThink()
	for ent, songdata in pairs(SONGS) do
		ProcessSong(songdata)
	end
end

local function InitializeSong(songdata)
	local systime = SysTime()
	local song = songdata.Song

	songdata.SongInstruments = {}
	songdata.TrackStatus = {}
	for i, track in ipairs(songdata.Song.Tracks) do
		local pitches = song.Tracks[i].Pitches
		songdata.SongInstruments[i] = CreateSound(songdata.SoundEntity, Instruments[track.Instrument])
		songdata.TrackStatus[i] = {
			CurrentSlot = 1,
			CurrentPitch = pitches[1] or 0,
			NextPitchTime = systime + (pitches[2] or 1)
		}
	end

	hook.Add("Think", "SongsThink", SongThink)
end

function NDB.PlaySong(song, volume, parent)
	local songdata = {}
	songdata.Song = song
	songdata.StartTime = SysTime()
	songdata.Volume = volume or 0.75
	songdata.SoundEntity = parent

	SONGS[parent] = songdata

	InitializeSong(songdata)

	return songdata
end
