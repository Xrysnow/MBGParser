

mbg.Mask = {}

local function _Mask()
    local ret = {
        ['ID']         = 0,
        ['层ID']        = 0,
        ['位置坐标']       = mbg.Position(),
        ['起始']         = 0,
        ['持续']         = 0,
        ['半宽']         = 0,
        ['半高']         = 0,
        ['启用圆形']       = false,
        ['类型']         = mbg.ControlType.All,
        ['控制ID']       = 0,
        ['运动']         = mbg.Motion(mbg.ValueWithRand),
        ['速度方向_坐标指定']  = mbg.Position(),
        ['加速度方向_坐标指定'] = mbg.Position(),

    -- public List<EventGroup>
        ['发射器事件组']     = {},
        ['子弹事件组']      = {},

        ['绑定ID']       = 0,
        ['深度绑定']       = false,
    }

    return ret
end

local mt = {
    __call = function()
        return _Mask()
    end
}
setmetatable(mbg.Mask, mt)

function mbg.Mask.ParseFrom(content)
    local m = mbg.Mask()
    m['ID'] = mbg.ReadUInt(content)
    m['层ID'] = mbg.ReadUInt(content)
    m['位置坐标'].X = mbg.ReadDouble(content)
    m['位置坐标'].Y = mbg.ReadDouble(content)

    m['起始'] = mbg.ReadUInt(content)
    m['持续'] = mbg.ReadUInt(content)
    m['半宽'] = mbg.ReadDouble(content)
    m['半高'] = mbg.ReadDouble(content)
    m['启用圆形'] = mbg.ReadBool(content)

    m['类型'] = --[[mbg.(ControlType)]]mbg.ReadUInt(content)
    m['控制ID'] = mbg.ReadUInt(content)
    m['运动'].Speed.BaseValue = mbg.ReadDouble(content)
    m['运动'].SpeedDirection.BaseValue = mbg.ReadDouble(content)
    m['速度方向_坐标指定'] = mbg.ReadPosition(content)
    m['运动'].Acceleration.BaseValue = mbg.ReadDouble(content)
    m['运动'].AccelerationDirection.BaseValue = mbg.ReadDouble(content)
    m['加速度方向_坐标指定'] = mbg.ReadPosition(content)

    m['发射器事件组'] = mbg.EventGroup.ParseEventGroups(mbg.ReadString(content))
    m['子弹事件组'] = mbg.EventGroup.ParseEventGroups(mbg.ReadString(content))

    m['运动'].Speed.RandValue = mbg.ReadDouble(content)
    m['运动'].SpeedDirection.RandValue = mbg.ReadDouble(content)
    m['运动'].Acceleration.RandValue = mbg.ReadDouble(content)
    m['运动'].AccelerationDirection.RandValue = mbg.ReadDouble(content)

    m['绑定ID'] = mbg.ReadInt(content)
    m['深度绑定'] = mbg.ReadBool(content)

    if not content:isempty() then
        error("遮罩解析后剩余字符串：" .. content:tostring())
    end
    return m
end
