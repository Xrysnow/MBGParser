

mbg.LazerEmitter={}

local function _LazerEmitter()
    local ret={
        ['ID']=0,
        ['层ID']=0,
        ['绑定状态']=false,
        ['绑定ID']=0,
        ['相对方向']=false,
        ['位置坐标']=mbg.Position(),
        ['起始']=0,
        ['持续']=0,
        ['半径']=mbg.ValueWithRand(),
        ['半径方向']=mbg.ValueWithRand(),
        ['半径方向_坐标指定']=mbg.Position(),
        ['条数']=mbg.ValueWithRand(),
        ['周期']=mbg.ValueWithRand(),
        ['发射角度']=mbg.ValueWithRand(),
        ['发射角度_坐标指定']=mbg.Position(),
        ['范围']=mbg.ValueWithRand(),
        ['发射器运动']=mbg.Motion(mbg.ValueWithRand),
        ['速度方向_坐标指定']=mbg.Position(),
        ['加速度方向_坐标指定']=mbg.Position(),
        ['子弹生命']=0,
        ['类型']=0,
        ['宽比']=0,
        ['长度']=0,
        ['不透明度']=0,
        ['子弹运动']=mbg.Motion(mbg.ValueWithRand),
        ['子弹速度方向_坐标指定']=mbg.Position(),
        ['子弹加速度方向_坐标指定']=mbg.Position(),
        ['横比']=0,
        ['纵比']=0,
        ['高光效果']=false,
        ['出屏即消']=false,
        ['无敌状态']=false,

    -- public List<EventGroup>
        ['发射器事件组']={},
        ['子弹事件组']={},

        ['启用射线激光']=false,
        ['深度绑定']=false,
    }

    return ret
end

local mt = {
    __call = function()
        return _LazerEmitter()
    end
}
setmetatable(mbg.LazerEmitter, mt)

function mbg.LazerEmitter.ParseFrom(c)
    local l=mbg.LazerEmitter()
    l['ID'] = mbg.ReadUInt(c)
    l['层ID'] = mbg.ReadUInt(c)
    l['绑定状态'] = mbg.ReadBool(c)
    l['绑定ID'] = mbg.ReadInt(c)
    l['相对方向'] = mbg.ReadBool(c)
    mbg.ReadString(c)  --TODO:CrazyStorm未描述此格数据内容
    l['位置坐标'].X = mbg.ReadDouble(c)
    l['位置坐标'].Y = mbg.ReadDouble(c)
    l['起始'] = mbg.ReadUInt(c)
    l['持续'] = mbg.ReadUInt(c)
    l['半径'].BaseValue = mbg.ReadDouble(c)
    l['半径方向'].BaseValue = mbg.ReadDouble(c)
    l['半径方向_坐标指定'] = mbg.ReadPosition(c)
    l['条数'].BaseValue = mbg.ReadDouble(c)
    l['周期'].BaseValue = mbg.ReadDouble(c)
    l['发射角度'].BaseValue = mbg.ReadDouble(c)
    l['发射角度_坐标指定'] = mbg.ReadPosition(c)
    l['范围'].BaseValue = mbg.ReadDouble(c)
    l['发射器运动'].Speed.BaseValue = mbg.ReadDouble(c)
    l['发射器运动'].SpeedDirection.BaseValue = mbg.ReadDouble(c)
    l['速度方向_坐标指定'] = mbg.ReadPosition(c)
    l['发射器运动'].Acceleration.BaseValue = mbg.ReadDouble(c)
    l['发射器运动'].AccelerationDirection.BaseValue = mbg.ReadDouble(c)
    l['加速度方向_坐标指定'] = mbg.ReadPosition(c)
    l['子弹生命'] = mbg.ReadUInt(c)
    l['类型'] = mbg.ReadUInt(c)
    l['宽比'] = mbg.ReadDouble(c)
    l['长度'] = mbg.ReadDouble(c)
    l['不透明度'] = mbg.ReadDouble(c)
    l['启用射线激光'] = mbg.ReadBool(c)
    l['子弹运动'].Speed.BaseValue = mbg.ReadDouble(c)
    l['子弹运动'].SpeedDirection.BaseValue = mbg.ReadDouble(c)
    l['子弹速度方向_坐标指定'] = mbg.ReadPosition(c)
    l['子弹运动'].Acceleration.BaseValue = mbg.ReadDouble(c)
    l['子弹运动'].AccelerationDirection.BaseValue = mbg.ReadDouble(c)
    l['子弹加速度方向_坐标指定'] = mbg.ReadPosition(c)
    l['横比'] = mbg.ReadDouble(c)
    l['纵比'] = mbg.ReadDouble(c)
    l['高光效果'] = mbg.ReadBool(c)
    l['出屏即消'] = mbg.ReadBool(c)
    l['无敌状态'] = mbg.ReadBool(c)
    mbg.ReadString(c)
    l['发射器事件组'] = mbg.EventGroup.ParseEventGroups(mbg.ReadString(c))
    l['子弹事件组'] = mbg.EventGroup.ParseEventGroups(mbg.ReadString(c))
    l['半径'].RandValue = mbg.ReadDouble(c)
    l['半径方向'].RandValue = mbg.ReadDouble(c)
    l['条数'].RandValue = mbg.ReadDouble(c)
    l['周期'].RandValue = mbg.ReadDouble(c)
    l['发射角度'].RandValue = mbg.ReadDouble(c)
    l['范围'].RandValue = mbg.ReadDouble(c)
    l['发射器运动'].Speed.RandValue = mbg.ReadDouble(c)
    l['发射器运动'].SpeedDirection.RandValue = mbg.ReadDouble(c)
    l['发射器运动'].Acceleration.RandValue = mbg.ReadDouble(c)
    l['发射器运动'].AccelerationDirection.RandValue = mbg.ReadDouble(c)
    l['子弹运动'].Speed.RandValue = mbg.ReadDouble(c)
    l['子弹运动'].SpeedDirection.RandValue = mbg.ReadDouble(c)
    l['子弹运动'].Acceleration.RandValue = mbg.ReadDouble(c)
    l['子弹运动'].AccelerationDirection.RandValue = mbg.ReadDouble(c)
    l['深度绑定'] = mbg.ReadBool(c)
    if not c:isempty() then
        error("激光发射器解析后剩余字符串：" .. c:tostring())
    end
    return l
end
