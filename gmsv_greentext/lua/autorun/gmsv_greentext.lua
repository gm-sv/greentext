require("gmsv")

local color_console = Color(150, 210, 255, 255)
local color_greentext = Color(170, 215, 50, 255)
local color_red = Color(255, 0, 0, 255)
local color_white = Color(255, 255, 255, 255)

gmsv.StartModule("GreenText")
do
	if CLIENT then
		function ParseChatText(Player, Text, IsTeamChat, IsDead)
			local StartPos = string.find(Text, ">")

			local BeforeArrow = string.sub(Text, 1, StartPos and (StartPos - 1) or -1)
			local AfterArrow

			if StartPos then
				AfterArrow = string.sub(Text, StartPos)
			end

			local TeamColor = IsValid(Player) and team.GetColor(Player:Team()) or color_console
			local Message = util.Stack()

			if IsDead then
				Message:Push(color_red)
				Message:Push("(DEAD) ")
			end

			if IsTeamChat then
				Message:Push(TeamColor)
				Message:Push("(TEAM) ")
			end

			Message:Push(TeamColor)
			Message:Push(IsValid(Player) and Player:GetName() or "Console")
			Message:Push(color_white)
			Message:Push(": ")
			Message:Push(BeforeArrow)

			if AfterArrow then
				Message:Push(color_greentext)
				Message:Push(AfterArrow)
			end

			chat.AddText(unpack(Message))

			return true
		end

		function OnEnabled(self)
			hook.Add("OnPlayerChat", self:GetName(), self.ParseChatText)
		end

		function OnDisabled(self)
			hook.Remove("OnPlayerChat", self:GetName())
		end
	end
end
gmsv.EndModule()
