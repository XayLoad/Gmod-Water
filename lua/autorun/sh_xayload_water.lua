
hook.Add( "Move", "XayLoadWaterMove", function( ply, move )
    if (ply.xl_InWater == true) then

        ply:SetGravity(0.1)

        local FavVel = nil

        if ply:KeyDown( IN_FORWARD ) then
            FavVel = ply:EyeAngles():Forward()
        end
        
        if ply:KeyDown( IN_BACK ) then
            FavVel = ply:EyeAngles():Forward()*-1
        end

        if ply:KeyDown( IN_MOVERIGHT ) then
            FavVel = ( FavVel or Vector(0,0,0) ) * 0.6 + ply:GetRight() * 0.6
        end
        
        if ply:KeyDown( IN_MOVELEFT ) then
            FavVel = ( FavVel or Vector(0,0,0) ) * 0.6 + ply:GetRight() * -0.6
        end

        if ply:KeyDown( IN_JUMP ) then
            if not FavVel then FavVel = Vector(0,0,0) end
            FavVel.z = 40
        end

        if ply:KeyDown( IN_DUCK ) then
            if not FavVel then FavVel = Vector(0,0,0) end
            FavVel.z = -20
        end

        if not FavVel then
            FavVel = Vector(0, 0, -0.2)
        end

        local curVel = move:GetVelocity()

        curVel.z = 0

        move:SetVelocity( curVel + FavVel )

        print( curVel + (FavVel - curVel) / 100)

        FavVel = nil
    else
        ply:SetGravity(1)
    end
end )

if CLIENT then
    hook.Add( "RenderScreenspaceEffects", "XayLoadWaterEffect", function()
        if LocalPlayer().xl_InWater then
            DrawMaterialOverlay("models/shadertest/shader3", 0.003)
            LocalPlayer():SetDSP(30)
        else
            LocalPlayer():SetDSP(0)
        end
    end )
end

