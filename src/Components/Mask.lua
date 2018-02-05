

mbg.Mask = {}

local function _Mask()
    local ret = {
        ['ID']     = 0,
        ['层ID']    = 0,
        ['绑定状态']   = mbg.BindState(),
        ['位置坐标']   = mbg.Position(),
        ['生命']     = mbg.Life(),
        ['半宽']     = 0,
        ['半高']     = 0,
        ['启用圆形']   = false,
        ['类型']     = mbg.ControlType.All,
        ['控制ID']   = 0,
        ['运动']     = mbg.MotionWithPosition(mbg.ValueWithRand),
        ['发射器事件组'] = {},
        ['子弹事件组']  = {},
    }
    return ret
end

local mt = {
    __call = function()
        return _Mask()
    end
}
setmetatable(mbg.Mask, mt)

function mbg.Mask.ParseFrom(content, layer)
    local tmp                             = {}
    local m                               = mbg.Mask()
    m['ID']                               = mbg.ReadUInt(content)
    m['层ID']                              = mbg.ReadUInt(content)
    m['位置坐标'].X                           = mbg.ReadDouble(content)
    m['位置坐标'].Y                           = mbg.ReadDouble(content)

    m['生命'].Begin                         = mbg.ReadUInt(content)
    m['生命'].LifeTime                      = mbg.ReadUInt(content)

    m['半宽']                               = mbg.ReadDouble(content)
    m['半高']                               = mbg.ReadDouble(content)
    m['启用圆形']                             = mbg.ReadBool(content)

    m['类型']                               = mbg.ReadUInt(content)
    m['控制ID']                             = mbg.ReadUInt(content)

    m['运动'].Motion.Speed
           .BaseValue                     = mbg.ReadDouble(content)
    m['运动'].Motion.SpeedDirection
           .BaseValue                     = mbg.ReadDouble(content)
    m['运动'].SpeedDirectionPosition        = mbg.ReadPosition(content)
    m['运动'].Motion.Acceleration
           .BaseValue                     = mbg.ReadDouble(content)
    m['运动'].Motion.AccelerationDirection
           .BaseValue                     = mbg.ReadDouble(content)
    m['运动'].AccelerationDirectionPosition = mbg.ReadPosition(content)

    m['发射器事件组']                           = mbg.EventGroup.ParseEventGroups(mbg.ReadString(content))
    m['子弹事件组']                            = mbg.EventGroup.ParseEventGroups(mbg.ReadString(content))

    m['运动'].Motion.Speed
           .RandValue                     = mbg.ReadDouble(content)
    m['运动'].Motion.SpeedDirection
           .RandValue                     = mbg.ReadDouble(content)
    m['运动'].Motion.Acceleration
           .RandValue                     = mbg.ReadDouble(content)
    m['运动'].Motion.AccelerationDirection
           .RandValue                     = mbg.ReadDouble(content)

    tmp['绑定ID']                           = mbg.ReadInt(content)
    tmp['深度绑定']                           = mbg.ReadBool(content)
    local binder                          = function()
    end
    if tmp['绑定ID'] ~= -1 then
        binder = function()
            m['绑定状态'] = layer
                    :FindBulletEmitterByID(tmp['绑定ID'])
                    :Bind(m, tmp['深度绑定'], false)
        end
    end
    if not content:isempty() then
        error("遮罩解析后剩余字符串：" .. content:tostring())
    end
    return m, binder
end

