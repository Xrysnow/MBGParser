

mbg.BindState = {}

local function _BindState()
    return {
        Parent   = mbg.BulletEmitter(),
        Child    = {},
        Depth    = false,
        Relative = false,
    }
end

local mt = {
    __call = function()
        return _BindState()
    end
}
setmetatable(mbg.BulletEmitter, mt)

