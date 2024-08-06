require("gmsv")

local color_greentext = Color(170, 215, 50, 255)
local color_red = Color(255, 0, 0, 255)
local color_white = Color(255, 255, 255, 255)

gmsv.StartModule("greentext")
do
	if CLIENT then
		function ParseChatText(Player, Text, IsTeamChat, IsDead)
			local StartPos = string.find(Text, ">")
			if not StartPos then return end

			local BeforeArrow = string.sub(Text, 1, StartPos - 1)
			local AfterArrow = string.sub(Text, StartPos)

			local TeamColor = team.GetColor(Player:Team())
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
			Message:Push(Player:GetName())
			Message:Push(color_white)
			Message:Push(": ")

			Message:Push(BeforeArrow)
			Message:Push(color_greentext)
			Message:Push(AfterArrow)

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
