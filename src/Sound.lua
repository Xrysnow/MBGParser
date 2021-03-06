---
--- Sound.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


---@class mbg.Sound
local Sound = {}
mbg.Sound = Sound

local function _Sound()
    ---@type mbg.Sound
    local ret = {}
    ret.BulletType = 0
    ret.FileName   = String()
    ret.Volume     = 0
    return ret
end

local mt = {
    __call = function()
        return _Sound()
    end
}
setmetatable(Sound, mt)

---ParseFrom
---@param c String
---@return mbg.Sound
local function ParseFrom(c)
    local s      = mbg.Sound()
    s.BulletType = mbg.ReadUInt(c, '_')
    s.FileName   = mbg.ReadString(c, '_')
    s.Volume     = mbg.ReadDouble(c, '_')
    if not c:isempty() then
        error("音效字符串解析后剩余："..c:tostring())
    end
    return s
end

---ParseSounds
---@param title String
---@param _mbg String
---@return mbg.Sound[]
function Sound.ParseSounds(title, _mbg)
    local soundCount = title:sub(1, title:find("Sounds") - 1):trim():toint();
    local ret = {}
    for i = 1, soundCount do
        table.insert(ret, ParseFrom(_mbg:readline()))
    end
    return ret
end

