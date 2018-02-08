---
--- Center.lua
---
--- Copyright (C) 2018 Xrysnow. All rights reserved.
---


---@class mbg.Center
local Center = {}
mbg.Center   = Center

local function _Center()
    ---@type mbg.Center
    local ret    = {}
    ret.Position = mbg.Position()
    ret.Motion   = mbg.Motion()
    ---@type mbg.Event[]
    ret.Events   = {}
    return ret
end

local mt = {
    __call = function()
        return _Center()
    end
}
setmetatable(Center, mt)

---ParseFromContent
---@param content String
---@return mbg.Center
function Center.ParseFromContent(content)
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

