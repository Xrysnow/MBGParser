

mbg.ReflexBoard = {}

local function _ReflexBoard()
    local ret = {
        ['ID']    = 0,
        ['层ID']   = 0,
        ['位置坐标']  = mbg.Position(),
        ['生命']    = mbg.Life(),
        ['长度']    = 0,
        ['角度']    = 0,
        ['次数']    = 0,
        ['运动']    = mbg.Motion(mbg.ValueWithRand),
        ['碰撞事件组'] = {},
    }
    return ret
end

local mt = {
    __call = function()
        return _ReflexBoard()
    end
}
setmetatable(mbg.ReflexBoard, mt)

function mbg.ReflexBoard.ParseFrom(content)
    local r           = mbg.ReflexBoard()
    r['ID']           = mbg.ReadUInt(content)
    r['层ID']          = mbg.ReadUInt(content)

    r['位置坐标'].X       = mbg.ReadDouble(content)
    r['位置坐标'].Y       = mbg.ReadDouble(content)

    r['生命'].Begin     = mbg.ReadUInt(content)
    r['生命'].LifeTime  = mbg.ReadUInt(content)

    r['长度']           = mbg.ReadDouble(content)
    r['角度']           = mbg.ReadDouble(content)
    r['次数']           = mbg.ReadUInt(content)

    r['运动'].Speed
           .BaseValue = mbg.ReadDouble(content)
    r['运动'].SpeedDirection
           .BaseValue = mbg.ReadDouble(content)
    r['运动'].Acceleration
           .BaseValue = mbg.ReadDouble(content)
    r['运动'].AccelerationDirection
           .BaseValue = mbg.ReadDouble(content)

    r['碰撞事件组']        = mbg.ReflexBoardAction.ParseActions(mbg.ReadString(content))

    r['运动'].Speed
           .RandValue = mbg.ReadDouble(content)
    r['运动'].SpeedDirection
           .RandValue = mbg.ReadDouble(content)
    r['运动'].Acceleration
           .RandValue = mbg.ReadDouble(content)
    r['运动'].AccelerationDirection
           .RandValue = mbg.ReadDouble(content)

    if not content:isempty() then
        error("反弹板解析后字符串剩余：" .. content:tostring())
    end
    return r
end

