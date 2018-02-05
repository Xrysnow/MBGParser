

mbg.LazerEmitter = {}

local function _LazerEmitter()
    local ret = {
        ['ID']        = 0,
        ['层ID']       = 0,
        ['绑定状态']      = mbg.BindState(),
        ['位置坐标']      = mbg.Position(),
        ['生命']        = mbg.Life(),
        ['半径']        = mbg.ValueWithRand(),
        ['半径方向']      = mbg.ValueWithRand(),
        ['半径方向_坐标指定'] = mbg.Position(),
        ['条数']        = mbg.ValueWithRand(),
        ['周期']        = mbg.ValueWithRand(),
        ['发射角度']      = mbg.ValueWithRand(),
        ['发射角度_坐标指定'] = mbg.Position(),
        ['范围']        = mbg.ValueWithRand(),
        ['发射器运动']     = mbg.MotionWithPosition(mbg.ValueWithRand),
        ['子弹生命']      = 0,
        ['类型']        = 0,
        ['宽比']        = 0,
        ['长度']        = 0,
        ['不透明度']      = 0,
        ['子弹运动']      = mbg.MotionWithPosition(mbg.ValueWithRand),
        ['横比']        = 0,
        ['纵比']        = 0,
        ['高光效果']      = false,
        ['出屏即消']      = false,
        ['无敌状态']      = false,
        ['发射器事件组']    = {},
        ['子弹事件组']     = {},
        ['启用射线激光']    = false,
    }
    return ret
end

local mt = {
    __call = function()
        return _LazerEmitter()
    end
}
setmetatable(mbg.LazerEmitter, mt)

function mbg.LazerEmitter.ParseFrom(c, layer)
    local tmp   = {}
    local l     = mbg.LazerEmitter()
    l['ID']     = mbg.ReadUInt(c)
    l['层ID']    = mbg.ReadUInt(c)
    --可能已废弃
    tmp['绑定状态'] = mbg.ReadBool(c)
    tmp['绑定ID'] = mbg.ReadInt(c)
    tmp['相对方向'] = mbg.ReadBool(c)
    mbg.ReadString(c)  --TODO:CrazyStorm未描述此格数据内容
    l['位置坐标'].X                                       = mbg.ReadDouble(c)
    l['位置坐标'].Y                                       = mbg.ReadDouble(c)

    l['生命'].Begin                                     = mbg.ReadUInt(c)
    l['生命'].LifeTime                                  = mbg.ReadUInt(c)

    l['半径'].BaseValue                                 = mbg.ReadDouble(c)
    l['半径方向'].BaseValue                               = mbg.ReadDouble(c)
    l['半径方向_坐标指定']                                    = mbg.ReadPosition(c)
    l['条数'].BaseValue                                 = mbg.ReadDouble(c)
    l['周期'].BaseValue                                 = mbg.ReadDouble(c)
    l['发射角度'].BaseValue                               = mbg.ReadDouble(c)
    l['发射角度_坐标指定']                                    = mbg.ReadPosition(c)
    l['范围'].BaseValue                                 = mbg.ReadDouble(c)

    l['发射器运动'].Motion.Speed.BaseValue                 = mbg.ReadDouble(c)
    l['发射器运动'].Motion.SpeedDirection.BaseValue        = mbg.ReadDouble(c)
    l['发射器运动'].SpeedDirectionPosition                 = mbg.ReadPosition(c)
    l['发射器运动'].Motion.Acceleration.BaseValue          = mbg.ReadDouble(c)
    l['发射器运动'].Motion.AccelerationDirection.BaseValue = mbg.ReadDouble(c)
    l['发射器运动'].AccelerationDirectionPosition          = mbg.ReadPosition(c)

    l['子弹生命']                                         = mbg.ReadUInt(c)
    l['类型']                                           = mbg.ReadUInt(c)
    l['宽比']                                           = mbg.ReadDouble(c)
    l['长度']                                           = mbg.ReadDouble(c)
    l['不透明度']                                         = mbg.ReadDouble(c)
    l['启用射线激光']                                       = mbg.ReadBool(c)

    l['子弹运动'].Motion.Speed.BaseValue                  = mbg.ReadDouble(c)
    l['子弹运动'].Motion.SpeedDirection.BaseValue         = mbg.ReadDouble(c)
    l['子弹运动'].SpeedDirectionPosition                  = mbg.ReadPosition(c)
    l['子弹运动'].Motion.Acceleration.BaseValue           = mbg.ReadDouble(c)
    l['子弹运动'].Motion.AccelerationDirection.BaseValue  = mbg.ReadDouble(c)
    l['子弹运动'].AccelerationDirectionPosition           = mbg.ReadPosition(c)

    l['横比']                                           = mbg.ReadDouble(c)
    l['纵比']                                           = mbg.ReadDouble(c)
    l['高光效果']                                         = mbg.ReadBool(c)
    l['出屏即消']                                         = mbg.ReadBool(c)
    l['无敌状态']                                         = mbg.ReadBool(c)
    mbg.ReadString(c)
    l['发射器事件组']                                       = mbg.EventGroup.ParseEventGroups(mbg.ReadString(c))
    l['子弹事件组']                                        = mbg.EventGroup.ParseEventGroups(mbg.ReadString(c))
    l['半径'].RandValue                                 = mbg.ReadDouble(c)
    l['半径方向'].RandValue                               = mbg.ReadDouble(c)
    l['条数'].RandValue                                 = mbg.ReadDouble(c)
    l['周期'].RandValue                                 = mbg.ReadDouble(c)
    l['发射角度'].RandValue                               = mbg.ReadDouble(c)
    l['范围'].RandValue                                 = mbg.ReadDouble(c)

    l['发射器运动'].Motion.Speed.RandValue                 = mbg.ReadDouble(c)
    l['发射器运动'].Motion.SpeedDirection.RandValue        = mbg.ReadDouble(c)
    l['发射器运动'].Motion.Acceleration.RandValue          = mbg.ReadDouble(c)
    l['发射器运动'].Motion.AccelerationDirection.RandValue = mbg.ReadDouble(c)

    l['子弹运动'].Motion.Speed.RandValue                  = mbg.ReadDouble(c)
    l['子弹运动'].Motion.SpeedDirection.RandValue         = mbg.ReadDouble(c)
    l['子弹运动'].Motion.Acceleration.RandValue           = mbg.ReadDouble(c)
    l['子弹运动'].Motion.AccelerationDirection.RandValue  = mbg.ReadDouble(c)

    tmp['深度绑定']                                       = mbg.ReadBool(c)
    local binder                                      = function()
    end
    if tmp['绑定ID'] ~= -1 then
        binder = function()
            l['绑定状态'] = layer
                    :FindBulletEmitterByID(tmp['绑定ID'])
                    :Bind(l, tmp['深度绑定'], tmp['相对方向'])
        end
    end
    if not c:isempty() then
        error("激光发射器解析后剩余字符串：" .. c:tostring())
    end
    return l, binder
end

