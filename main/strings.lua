-- The actual strings are located in the-kleiground/strings/common.lua
-- Note to translators: Update the POT file using KLEIGROUND_makePOT() in the in-game console if we forget to

-- Update this list when adding files
local _speech = {
	"generic",
	"willow",
	"wolfgang",
	"wendy",
	"wx78",
	"wickerbottom",
	"woodie",
	--"wes",
	"waxwell",
	"wathgrithr",
	"webber",
}
local _newspeech = {
	"wobert",
	-- "iimaria",
}
local _languages = {
	-- de = "de", --german
	-- es = "es", --spanish
	-- fr = "fr", --french
	-- it = "it", --italian
	-- ko = "ko", --korean
	--Note: The only language mod I found that uses "pt" is also brazilian portuguese -M
	-- pt = "pt", --portuguese
	-- br = "pt", --brazilian portuguese
	-- pl = "pl", --polish
	-- ru = "ru", --russian
	-- zh = "sc", --chinese
	-- sc = "sc", --simple chinese
	-- tc = "tc", --traditional chinese
}

local function merge(target, new, soft)
	if not target then target = {} end
	for k,v in pairs(new) do
		if type(v) == "table" then
			target[k] = type(target[k]) == "table" and target[k] or {}
			merge(target[k], v)
		else
			if target[k] then
				if soft then
					print("couldn't add ".. k, " (already is \"".. target[k] .."\")")
				else
					print("replacing ".. k, " (with \"".. v .."\")")
					target[k] = v
				end
			else
				target[k] = v
			end
		end
	end
	return target
end

-- Install our crazy loader!
local function import(modulename)
	print("modimport (strings file): "..MODROOT.."strings/"..modulename)
	-- if string.sub(modulename, #modulename-3,#modulename) ~= ".lua" then
		-- modulename = modulename..".lua"
	-- end
	local result = GLOBAL.kleiloadlua(MODROOT.."strings/"..modulename)
	if result == nil then
		GLOBAL.error("Error in custom import: Stringsfile "..modulename.." not found!")
	elseif type(result) == "string" then
		GLOBAL.error("Error in custom import: Kleiground importing strings/"..modulename.."!\n"..result)
	else
		GLOBAL.setfenv(result, env) -- in case we use mod data
		return result()
	end
end

merge(GLOBAL.STRINGS, import("common.lua"))

-- add character speech
for _,v in pairs(_speech) do
	merge(GLOBAL.STRINGS.CHARACTERS[string.upper(v)], import(v..".lua"))
end
for _,v in pairs(_newspeech) do
	GLOBAL.STRINGS.CHARACTERS[string.upper(v)] = import(v..".lua")
end

-- TRANSLATIONS --

local function flattenStringsTable(src, root, target)
	GLOBAL.assert(type(src) == "table", "flattenStringsTable requires a table to flatten!")
	root = root or ""
	target = target or {}
	for k, v in pairs(src) do
		if type(v) == "table" then
			flattenStringsTable(v, root..k..".", target)
		else
			target[root..k] = tostring(v)
		end
	end
	return target
end

GLOBAL.KLEIGROUND_makePOT = function()
	--create the file
	local file, errormsg = GLOBAL.io.open(MODROOT .. "languages/strings.pot", "w")
	if not file then print("FAILED TO GENERATE .POT:\n".. tostring(errormsg)) return end
	
	--write header
	file:write('#. Note to translators: Update the POT file using KLEIGROUND_makePOT() in the in-game console if we forget to\n')
	file:write('msgid ""\n')
	file:write('msgstr ""\n')
	file:write('"Application: Don\'t Starve\\n"\n')
	file:write('"POT Version: 2.0\\n"\n\n')
	
	--gather all the strings
	local _strings = flattenStringsTable(import("common.lua"), "STRINGS.")
	for _,v in pairs(_speech) do
		flattenStringsTable(import(v..".lua"), "STRINGS.CHARACTERS."..string.upper(v)..".", _strings)
	end
	for _,v in pairs(_newspeech) do
		flattenStringsTable(import(v..".lua"), "STRINGS.CHARACTERS."..string.upper(v)..".", _strings)
	end
	
	--write all the strings
	for k, v in pairs(_strings) do
		file:write('#. '..k.."\n")
		file:write('msgctxt "'..k..'"\n')
		file:write('msgid "'..v..'"\n')
		file:write('msgstr ""\n\n')
	end
	
	--done
	file:close()
end


GLOBAL.KLEIGROUND_makePOfromLua = function(lang)
	--create the file
	local file, errormsg = GLOBAL.io.open(MODROOT .. "strings/temp/new_"..lang..".po", "w")
	if not file then print("FAILED TO GENERATE .PO:\n".. tostring(errormsg)) return end
	
	--write header
	file:write('msgid ""\n')
	file:write('msgstr ""\n')
	file:write('"Language: kleiground_'..lang..'\n"\n')
	file:write('"Content-Type: text/plain; charset=utf-8\n"\n')
	file:write('"Content-Transfer-Encoding: 8bit\n"\n')
	file:write('"POT Version: 2.0\\n"\n\n')
	
	--gather and write all the strings
	local _strings = flattenStringsTable(import("temp/strings_"..lang..".lua"), "STRINGS.")
	for k, v in pairs(_strings) do
		file:write('#. '..k.."\n")
		file:write('msgctxt "'..k..'"\n')
		file:write('msgid "'..v..'"\n') -- could extract original string using k
		file:write('msgstr "'..v..'"\n\n')
	end
	-- loaded by strings.lua
	-- for _,v in pairs(_speech) do
		-- _strings = flattenStringsTable(import("temp/speech_"..(v == "generic" and "wilson" or v)..".lua"), "STRINGS.CHARACTERS."..string.upper(v)..".")
		-- for k, v in pairs(_strings) do
			-- file:write('#. '..k.."\n")
			-- file:write('msgctxt "'..k..'"\n')
			-- file:write('msgid "'..v..'"\n')
			-- file:write('msgstr "'..v..'"\n\n')
		-- end
	-- end
	for _,v in pairs(_newspeech) do
		_strings = flattenStringsTable(import("temp/speech_"..v.."_"..lang..".lua"), "STRINGS.CHARACTERS."..string.upper(v)..".")
		for k, v in pairs(_strings) do
			file:write('#. '..k.."\n")
			file:write('msgctxt "'..k..'"\n')
			file:write('msgid "'..v..'"\n')
			file:write('msgstr "'..v..'"\n\n')
		end
	end
	
	--done
	file:close()
end


GLOBAL.require("translator")


local LoadPOFile_old = GLOBAL.LanguageTranslator.LoadPOFile
GLOBAL.LanguageTranslator.LoadPOFile = function(self, fname, lang)
	LoadPOFile_old(self, fname, lang)
	if _languages[lang] then
		local _defaultlang = self.defaultlang
		-- Translator doesn't let us append existing languages
		-- instead we make "new" languages, then manually merge them into the actual language data
		self:LoadPOFile("languages/kleiground_".._languages[lang]..".po", lang.."_TEMP") 
		merge(
			self.languages[lang],
			self.languages[lang.."_TEMP"],
			true
		)
		self.languages[lang.."_TEMP"] = nil
		
		self.defaultlang = _defaultlang
	end
end

if GLOBAL.IA_CONFIG.locale then
	-- This only runs once. In order to make it last after loading other POs, adjust LoadPOFile to use IA_CONFIG. -M
	local _defaultlang = GLOBAL.LanguageTranslator.defaultlang
	GLOBAL.LanguageTranslator:LoadPOFile("languages/kleiground_".._languages[GLOBAL.IA_CONFIG.locale]..".po",
		GLOBAL.IA_CONFIG.locale.."_TEMP")
	if _defaultlang then
		merge(
			self.languages[_defaultlang],
			self.languages[lang.."_TEMP"],
			true
		)
		GLOBAL.LanguageTranslator.defaultlang = _defaultlang
	end
	GLOBAL.TranslateStringTable( GLOBAL.STRINGS )
	GLOBAL.LanguageTranslator.languages[GLOBAL.IA_CONFIG.locale.."_TEMP"] = nil
	GLOBAL.LanguageTranslator.defaultlang = _defaultlang
end
