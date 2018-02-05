

mbg.Layer = {}

local function _Layer()
    local ret       = {
        Name           = '',
        Life           = mbg.Life(),
        BulletEmitters = {},
        ReflexBoards   = {},
        ForceFields    = {},
        Masks          = {},
        LazerEmitters  = {},
    }
    ret.LoadContent = mbg.Layer.LoadContent
    return ret
end

local mt = {
    __call = function()
        return _Layer()
    end
}
setmetatable(mbg.Layer, mt)

function mbg.Layer:LoadContent(_mbg,
                               bulletEmitterCount,
                               lazerEmitterCount,
                               maskEmitterCount,
                               reflexBoardCount,
                               forceFieldCount)
    local linkers       = {}
    self.BulletEmitters = {}
    for i = 1, bulletEmitterCount do
        local i1, i2 = mbg.BulletEmitter.ParseFrom(_mbg:readline(), self)
        table.insert(linkers, i2)
        table.insert(self.BulletEmitters, i1)
    end
    self.LazerEmitters = {}
    for i = 1, lazerEmitterCount do
        local i1, i2 = mbg.LazerEmitter.ParseFrom(_mbg:readline(), self)
        table.insert(linkers, i2)
        table.insert(self.LazerEmitters, i1)
    end
    self.Masks = {}
    for i = 1, maskEmitterCount do
        local i1, i2 = mbg.Mask.ParseFrom(_mbg:readline(), self)
        table.insert(linkers, i2)
        table.insert(self.Masks, i1)
    end
    self.ReflexBoards = {}
    for i = 1, reflexBoardCount do
        table.insert(self.ReflexBoards, mbg.ReflexBoard.ParseFrom(_mbg:readline()))
    end
    self.ForceFields = {}
    for i = 1, forceFieldCount do
        table.insert(self.ForceFields, mbg.ForceField.ParseFrom(_mbg:readline()))
    end

    for _, l in pairs(linkers) do
        l()
    end
end

function mbg.Layer:FindBulletEmitterByID(id)
    for _, i in pairs(self.BulletEmitters) do
        if i.ID == id then
            return i
        end
    end
    error('找不到子弹发射器: ' .. id)
end

function mbg.Layer.ParseFrom(content, _mbg)
    if content:equalto("empty") then
        return nil
    else
        local layer              = mbg.Layer()
        layer.Name               = mbg.ReadString(content)
        layer.Life.Begin         = mbg.ReadString(content):toint()
        layer.Life.LifeTime      = mbg.ReadString(content):toint()
        local bulletEmitterCount = mbg.ReadString(content):toint()
        local lazerEmitterCount  = mbg.ReadString(content):toint()
        local maskEmitterCount   = mbg.ReadString(content):toint()
        local reflexBoardCount   = mbg.ReadString(content):toint()
        local forceFieldCount    = mbg.ReadString(content):toint()

        layer:LoadContent(
                _mbg,
                bulletEmitterCount,
                lazerEmitterCount,
                maskEmitterCount,
                reflexBoardCount,
                forceFieldCount)

        return layer
    end
end

