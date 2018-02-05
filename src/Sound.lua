

mbg.Sound = {}

local function _Sound()
    local ret = {
        BulletType = 0,
        FileName   = String(),
        Volume     = 0,
    }
    return ret
end

local mt = {
    __call = function()
        return _Sound()
    end
}
setmetatable(mbg.Sound, mt)

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

function mbg.Sound.ParseSounds(title, _mbg)
    local soundCount = title:sub(1, title:find("Sounds") - 1):trim():toint();
    local ret = {}
    for i = 1, soundCount do
        table.insert(ret, ParseFrom(_mbg:readline()))
    end
    return ret
end
