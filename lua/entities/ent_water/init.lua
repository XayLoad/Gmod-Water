AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("xl_StartTouch")
util.AddNetworkString("xl_EndTouch")

function ENT:Initialize()
    self:SetModel("models/props_wasteland/cargo_container01.mdl")

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self:SetCollisionGroup( COLLISION_GROUP_WORLD )
    self.CollisionGroup = COLLISION_GROUP_WORLD
    self:SetNotSolid(self:GetPlayer())

    self.Entity:SetTrigger( true )
end

function ENT:StartTouch( ent )
    if not IsValid( ent )
    or not IsValid( ent:GetPhysicsObject() ) then return end

    local pos = ent:GetPos()

    ent.xl_InWater = true  

    net.Start("xl_StartTouch")
        net.WriteEntity(ent)
    net.Send(ent)

    print( ent )
end

function ENT:EndTouch( ent )
    if not IsValid( ent )
    or not IsValid( ent:GetPhysicsObject() ) then return end

    ent.xl_InWater = false 

    net.Start("xl_EndTouch")
        net.WriteEntity(ent)
    net.Send(ent)

    print( ent )
end
