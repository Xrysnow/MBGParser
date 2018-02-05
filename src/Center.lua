

mbg.Center = {
    Position = mbg.Position(),
    Motion   = mbg.Motion(),
    Events   = {}
}

local function _Center()
    local ret = {
        Position = mbg.Position(),
        Motion   = mbg.Motion(),
        Events   = {}
    }
    return ret
end

local mt = {
    __call = function()
        return _Center()
    end
}
setmetatable(mbg.Center, mt)

function mbg.Center.ParseFromContent(content)
    if content:equalto("False") then
        return nil
    else
        local center                        = mbg.Center()

        center.Position.X                   = mbg.ReadString(content):tonumber()
        center.Position.Y                   = mbg.ReadString(content):tonumber()

        center.Motion.Speed                 = mbg.ReadString(content):tonumber()
        center.Motion.SpeedDirection        = mbg.ReadString(content):tonumber()

        center.Motion.Acceleration          = mbg.ReadString(content):tonumber()
        center.Motion.AccelerationDirection = mbg.ReadString(content):tonumber()

        center.Events                       = nil
        if not content:isempty() then
            center.Events = mbg.Event.ParseEvents(mbg.ReadString(content))
        end

        return center
    end
end
