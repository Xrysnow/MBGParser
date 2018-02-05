

mbg.Layer = {}

local function _Layer()
    local ret       = {
        Name           = '',
        BeginFrame     = 0,
        LifeTime       = 0,
        BulletEmitters = {},
        ReflexBoards   = {},
        ForceFields    = {},
        Masks          = {},
        LazerEmitters  = {},
    }

    ret.LoadContent = function(_mbg,
                               bulletEmitterCount,
                               lazerEmitterCount,
                               maskEmitterCount,
                               reflexBoardCount,
                               forceFieldCount)
        ret.BulletEmitters = {}
        for i = 1, bulletEmitterCount do
            table.insert(ret.BulletEmitters, mbg.BulletEmitter.ParseFrom(_mbg:readline()))
        end
        ret.LazerEmitters = {}
        for i = 1, lazerEmitterCount do
            table.insert(ret.LazerEmitters, mbg.LazerEmitter.ParseFrom(_mbg:readline()))
        end
        ret.Masks = {}
        for i = 1, maskEmitterCount do
            table.insert(ret.Masks, mbg.Mask.ParseFrom(_mbg:readline()))
        end
        ret.ReflexBoards = {}
        for i = 1, reflexBoardCount do
            table.insert(ret.ReflexBoards, mbg.ReflexBoard.ParseFrom(_mbg:readline()))
        end
        ret.ForceFields = {}
        for i = 1, forceFieldCount do
            table.insert(ret.ForceFields, mbg.ForceField.ParseFrom(_mbg:readline()))
        end
    end
    return ret
end

local mt = {
    __call = function()
        return _Layer()
    end
}
setmetatable(mbg.Layer, mt)

function mbg.Layer.ParseFrom(content, _mbg)
    if content:equalto("empty") then
        return nil
    else
        local layer              = mbg.Layer()
        layer.Name               = mbg.ReadString(content)
        layer.BeginFrame         = mbg.ReadString(content):toint()
        layer.LifeTime           = mbg.ReadString(content):toint()
        local bulletEmitterCount = mbg.ReadString(content):toint()
        local lazerEmitterCount  = mbg.ReadString(content):toint()
        local maskEmitterCount   = mbg.ReadString(content):toint()
        local reflexBoardCount   = mbg.ReadString(content):toint()
        local forceFieldCount    = mbg.ReadString(content):toint()

        layer.LoadContent(
                _mbg,
                bulletEmitterCount,
                lazerEmitterCount,
                maskEmitterCount,
                reflexBoardCount,
                forceFieldCount)

        return layer
    end
end
