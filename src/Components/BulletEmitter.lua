

mbg.BulletEmitter = {}

local function _BulletEmitter()
    local ret = {
        ['ID']           = 0,
        ['层ID']          = 0,

        ['绑定状态']         = false,

        ['绑定ID']         = 0,

        ['相对方向']         = false,

        ['位置坐标']         = mbg.Position(mbg.ValueWithRand),

        ['起始']           = 0,
        ['持续']           = 0,

        ['发射坐标']         = mbg.Position(),

        ['半径']           = mbg.ValueWithRand(),
        ['半径方向']         = mbg.ValueWithRand(),

        ['半径方向_坐标指定']    = mbg.Position(),

        ['条数']           = mbg.ValueWithRand(),
        ['周期']           = mbg.ValueWithRand(),

        ['发射角度']         = mbg.ValueWithRand(),

        ['发射角度_坐标指定']    = mbg.Position(),

        ['范围']           = mbg.ValueWithRand(),

        ['发射器运动']        = mbg.Motion(mbg.ValueWithRand),

        ['速度方向_坐标指定']    = mbg.Position(),
        ['加速度方向_坐标指定']   = mbg.Position(),

        ['子弹生命']         = 0,
        ['子弹类型']         = 0,

        ['宽比']           = 0,
        ['高比']           = 0,

        ['子弹颜色']         = mbg.Color(),

        ['朝向']           = mbg.ValueWithRand(),

        ['朝向_坐标指定']      = mbg.Position(),

        ['朝向与速度方向相同']    = false,

        ['子弹运动']         = mbg.Motion(mbg.ValueWithRand),

        ['子弹速度方向_坐标指定']  = mbg.Position(),
        ['子弹加速度方向_坐标指定'] = mbg.Position(),

        ['横比']           = 0,
        ['纵比']           = 0,

        ['雾化效果']         = false,
        ['消除效果']         = false,
        ['高光效果']         = false,
        ['拖影效果']         = false,
        ['出屏即消']         = false,
        ['无敌状态']         = false,

    --public List<EventGroup>
        ['发射器事件组']       = {},
        ['子弹事件组']        = {},

        ['遮罩']           = false,
        ['反弹板']          = false,
        ['力场']           = false,
        ['深度绑定']         = false,
    }
    return ret
end

local mt = {
    __call = function()
        return _BulletEmitter()
    end
}
setmetatable(mbg.BulletEmitter, mt)

mbg.BulletEmitter.ParseFrom = function(content)
    local e   = mbg.BulletEmitter()
    e['ID']   = mbg.ReadUInt(content)
    e['层ID']  = mbg.ReadUInt(content)
    e['绑定状态'] = mbg.ReadBool(content)
    e['绑定ID'] = mbg.ReadInt(content)
    e['相对方向'] = mbg.ReadBool(content)
    mbg.ReadString(content)
    e['位置坐标'].X.BaseValue                      = mbg.ReadDouble(content)
    e['位置坐标'].Y.BaseValue                      = mbg.ReadDouble(content)
    e['起始']                                    = mbg.ReadUInt(content)
    e['持续']                                    = mbg.ReadUInt(content)
    e['发射坐标'].X                                = mbg.ReadDouble(content)
    e['发射坐标'].Y                                = mbg.ReadDouble(content)
    e['半径'].BaseValue                          = mbg.ReadDouble(content)
    e['半径方向'].BaseValue                        = mbg.ReadDouble(content)
    e['半径方向_坐标指定']                             = mbg.ReadPosition(content)
    e['条数'].BaseValue                          = mbg.ReadDouble(content)
    e['周期'].BaseValue                          = mbg.ReadUInt(content)
    e['发射角度'].BaseValue                        = mbg.ReadDouble(content)
    e['发射角度_坐标指定']                             = mbg.ReadPosition(content)
    e['范围'].BaseValue                          = mbg.ReadDouble(content)

    e['发射器运动'].Speed.BaseValue                 = mbg.ReadDouble(content)
    e['发射器运动'].SpeedDirection.BaseValue        = mbg.ReadDouble(content)
    e['速度方向_坐标指定']                             = mbg.ReadPosition(content)
    e['发射器运动'].Acceleration.BaseValue          = mbg.ReadDouble(content)
    e['发射器运动'].AccelerationDirection.BaseValue = mbg.ReadDouble(content)
    e['加速度方向_坐标指定']                            = mbg.ReadPosition(content)

    e['子弹生命']                                  = mbg.ReadUInt(content)
    e['子弹类型']                                  = mbg.ReadUInt(content)

    e['宽比']                                    = mbg.ReadDouble(content)
    e['高比']                                    = mbg.ReadDouble(content)

    e['子弹颜色'].R                                = mbg.ReadDouble(content)
    e['子弹颜色'].G                                = mbg.ReadDouble(content)
    e['子弹颜色'].B                                = mbg.ReadDouble(content)
    e['子弹颜色'].A                                = mbg.ReadDouble(content)

    e['朝向'].BaseValue                          = mbg.ReadDouble(content)
    e['朝向_坐标指定']                               = mbg.ReadPosition(content)
    e['朝向与速度方向相同']                             = mbg.ReadBool(content)

    e['子弹运动'].Speed.BaseValue                  = mbg.ReadDouble(content)
    e['子弹运动'].SpeedDirection.BaseValue         = mbg.ReadDouble(content)
    e['子弹速度方向_坐标指定']                           = mbg.ReadPosition(content)
    e['子弹运动'].Acceleration.BaseValue           = mbg.ReadDouble(content)
    e['子弹运动'].AccelerationDirection.BaseValue  = mbg.ReadDouble(content)
    e['子弹加速度方向_坐标指定']                          = mbg.ReadPosition(content)

    e['横比']                                    = mbg.ReadDouble(content)
    e['纵比']                                    = mbg.ReadDouble(content)

    e['雾化效果']                                  = mbg.ReadBool(content)
    e['消除效果']                                  = mbg.ReadBool(content)
    e['高光效果']                                  = mbg.ReadBool(content)
    e['拖影效果']                                  = mbg.ReadBool(content)
    e['出屏即消']                                  = mbg.ReadBool(content)
    e['无敌状态']                                  = mbg.ReadBool(content)

    e['发射器事件组']                                = mbg.EventGroup.ParseEventGroups(mbg.ReadString(content))
    e['子弹事件组']                                 = mbg.EventGroup.ParseEventGroups(mbg.ReadString(content))

    e['位置坐标'].X.RandValue                      = mbg.ReadDouble(content)
    e['位置坐标'].Y.RandValue                      = mbg.ReadDouble(content)

    e['半径'].RandValue                          = mbg.ReadDouble(content)
    e['半径方向'].RandValue                        = mbg.ReadDouble(content)

    e['条数'].RandValue                          = mbg.ReadDouble(content)
    e['周期'].RandValue                          = mbg.ReadDouble(content)

    e['发射角度'].RandValue                        = mbg.ReadDouble(content)
    e['范围'].RandValue                          = mbg.ReadDouble(content)
    e['发射器运动'].Speed.RandValue                 = mbg.ReadDouble(content)
    e['发射器运动'].SpeedDirection.RandValue        = mbg.ReadDouble(content)
    e['发射器运动'].Acceleration.RandValue          = mbg.ReadDouble(content)
    e['发射器运动'].AccelerationDirection.RandValue = mbg.ReadDouble(content)
    e['朝向'].RandValue                          = mbg.ReadDouble(content)

    e['子弹运动'].Speed.RandValue                  = mbg.ReadDouble(content)
    e['子弹运动'].SpeedDirection.RandValue         = mbg.ReadDouble(content)
    e['子弹运动'].Acceleration.RandValue           = mbg.ReadDouble(content)
    e['子弹运动'].AccelerationDirection.RandValue  = mbg.ReadDouble(content)

    e['遮罩']                                    = mbg.ReadBool(content)
    e['反弹板']                                   = mbg.ReadBool(content)
    e['力场']                                    = mbg.ReadBool(content)

    e['深度绑定']                                  = mbg.ReadBool(content)

    if not content:isempty() then
        error("发射器解析后剩余字符串")
    end
    return e

end

