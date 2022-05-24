include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

net.Receive("xl_StartTouch", function ()
    local ply = net.ReadEntity()

    ply.xl_InWater = true
end)

net.Receive("xl_EndTouch", function (arguments)
    local ply = net.ReadEntity()

    if not ply.xl_InWater then return end

    if (ply.xl_InWater == true) then
        ply.xl_InWater = false
    end
end)
