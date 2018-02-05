

mbg.GlobalEvents = {}

local function _GlobalEvents()
    return {
        Frame          = 0,
        JumpEnabled    = false,
        JumpTarget     = 0,
        JumpTimes      = 0,
        VibrateEnabled = false,
        VibrateForce   = 0,
        VibrateTime    = 0,
        SleepEnabled   = false,
        SleepTime      = 0,
        SleepType      = 0,
    }
end

local mt = {
    __call = function()
        return _GlobalEvents()
    end
}
setmetatable(mbg.GlobalEvents, mt)

mbg.GlobalEvents.SleepModeType = {
    Tween = 0,
    Full  = 1
}

function mbg.GlobalEvents.ParseFrom(c)
    local ge = mbg.GlobalEvents()
    ge.Frame = mbg.ReadUInt(c, '_');
    mbg.ReadString(c, '_');
    mbg.ReadString(c, '_');
    mbg.ReadString(c, '_');

    ge.JumpEnabled = mbg.ReadBool(c, '_');
    ge.JumpTimes = mbg.ReadUInt(c, '_');
    ge.JumpTarget = mbg.ReadUInt(c, '_');

    mbg.ReadString(c, '_');
    mbg.ReadString(c, '_');
    mbg.ReadString(c, '_');

    ge.VibrateEnabled = mbg.ReadBool(c, '_');
    ge.VibrateTime = mbg.ReadUInt(c, '_');
    ge.VibrateForce = mbg.ReadDouble(c, '_');

    mbg.ReadString(c, '_');
    mbg.ReadString(c, '_');
    mbg.ReadString(c, '_');

    ge.SleepEnabled = mbg.ReadBool(c, '_');
    ge.SleepTime = mbg.ReadUInt(c, '_');
    ge.SleepType = mbg.ReadUInt(c, '_');

    if not c:isempty() then
        error("全局帧事件字符串解析剩余：" .. c:tostring())
    end
    return ge
end

function mbg.GlobalEvents.ParseEvents(title, _mbg)
    local ret        = {}
    local soundCount = title:sub(1, title:find('GlobalEvents') - 1):trim():toint()
    for i = 1, soundCount do
        table.insert(ret, mbg.GlobalEvents.ParseFrom(_mbg:readline()))
    end
    return ret
end
