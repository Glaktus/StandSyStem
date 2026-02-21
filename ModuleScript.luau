--[[     READ ME 

This game is a "Stand" system inspired by the Manga "Jojo Bizarre Adventure"

this game allows you to summon a stand and use it to fight

with 4 different attack inculude an ultimate attack that you can charge up by using the other 3 attacks

you can also change your keybinds in the parameters to any number or letter you want.There is also a key to summon and unsommon your stand

--]]


local module = {
	
	--SummonStand Function
	
	SummonStand = function(player,speed)

		local Stand = game.Workspace:WaitForChild(player.Name .. "Stand")
		local part = Stand:GetChildren()
		local Summoned = Stand:WaitForChild("Summoned").Value
		if Summoned == false then
			Stand.Summoned.Value=true
			for i=1,10 do
				Stand.Head.Transparency-=0.1
				for _,el in part do 
					if el.ClassName == "MeshPart" then
						el.Transparency=Stand.Head.Transparency
					end
				end
				task.wait(speed)
			end

		elseif Summoned==true then
			Stand.Summoned.Value=false
			for i=1,10 do
				Stand.Head.Transparency+=0.1
				for _,el in part do 
					if el.ClassName == "MeshPart" then
						el.Transparency=Stand.Head.Transparency
					end
				end
				task.wait(speed)
			end
		end

	end,
	
	
	--FollowingPlayer Function
	
	FollowingPlayer = function(player)

		local Stand = game.Workspace:FindFirstChild(player.Name .. "Stand")
		local following= true
		local StandFollowing = game.Workspace:FindFirstChild(player.Name.."Stand").StandFollowing

		while following == true  do

			if StandFollowing.Value == false  then
				following=false
			end

			if Stand then 
				local TweenService = game:GetService("TweenService")
				local TweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine)
				local goal = {
					CFrame=player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(5,0,5))
				}

				local Tween = TweenService:Create(Stand.HumanoidRootPart, TweenInfo, goal)
				Tween:Play()
			end
			if StandFollowing.Value == false  then
				following=false
			end
			task.wait()
		end
	end,
	

	
	
	--AttackOne Function
	
	
	AttackOne = function(player,Stand)
		
		local PunchSound = Stand.Sounds.PunchAttaqueOne
		local animation = Stand.Humanoid.Animator:loadAnimation(game.ReplicatedStorage.Animations.AttackOneStand)
		local PlayerAnimation = player.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Animations.PlayerAttackOne)
		Stand.IsAttacking.Value = true
		--stop following the player
		Stand.StandFollowing.Value = false
		task.wait(0.15)
			
		--TweenService
		local TweenService = game:GetService("TweenService")
		local TweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
		local goal = {
			CFrame=player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(5,0,-20))
		}

		local Tween = TweenService:Create(Stand.HumanoidRootPart, TweenInfo, goal)
		player.Character.HumanoidRootPart.Anchored = true
		PlayerAnimation:Play()
		Tween:Play()
			
		--Animation
		task.delay(0.3,function()
			animation:Play()
			animation:GetMarkerReachedSignal("punch1"):Connect(function()
				
				PunchSound:Play()
				if player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value < 92 then
					player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value+=5
				end
				
			end)
		end)
		
		task.delay(1.3,function()
			player.Character.HumanoidRootPart.Anchored = false
			task.wait(0.3)
			Stand.StandFollowing.Value = true
			task.wait(0.5)
			Stand.IsAttacking.Value = false
		end)
	end,
	
	
	
	--AttackTwo Function
	
	
	AttackTwo = function(player,Stand)

		local PunchSound = Stand.Sounds.PunchAttaqueTwo
		local PlayerAnimation = player.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Animations.PlayerAttackTwo)
		local animation = Stand.Humanoid.Animator:loadAnimation(game.ReplicatedStorage.Animations.AttackTwoStand)
		Stand.IsAttacking.Value = true
		Stand.StandFollowing.Value = false
		task.wait(0.11)

		--TweenService
		local TweenService = game:GetService("TweenService")
		local TweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
		local goal = {
			CFrame=player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(5,0,-20))
		}

		local Tween = TweenService:Create(Stand.HumanoidRootPart, TweenInfo, goal)
		player.Character.HumanoidRootPart.Anchored = true
		Tween:Play()

		--Animation 
		PlayerAnimation:Play()
		task.delay(0.2,function()
			animation:Play()
			animation:GetMarkerReachedSignal("smash"):Connect(function()
				PunchSound:Play()
				if player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value < 92 then
					player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value+=15
				end
			end)
		end)
		
		task.delay(1.4,function()
			player.Character.HumanoidRootPart.Anchored = false
			task.wait(0.5)
			Stand.StandFollowing.Value = true
			task.wait(0.5)
			Stand.IsAttacking.Value = false
		end)
    end,
	
	
	--AttackThree Function
	
	AttackThree = function(player,Stand)
		local PlayerAnimation = player.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Animations.PlayerAttackThree)

		local PunchSound = Stand.Sounds.PunchAttackThree
		local KickSound = Stand.Sounds.KickAttackThree
		local SmashingSound = Stand.Sounds.SmashingAttackThree
		local animation = Stand.Humanoid.Animator:loadAnimation(game.ReplicatedStorage.Animations.AttackThreeStand)
        Stand.IsAttacking.Value = true
		Stand.StandFollowing.Value = false
		task.wait(0.11)

		--TweenService
		local TweenService = game:GetService("TweenService")
		local TweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
		local goal = {
			CFrame=player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(5,0,-20))
		}

		local Tween = TweenService:Create(Stand.HumanoidRootPart, TweenInfo, goal)
		player.Character.HumanoidRootPart.Anchored = true
		Tween:Play()

		--Animation
		PlayerAnimation:Play()
		task.delay(0.2,function()
			animation:Play()
		end)
		animation:GetMarkerReachedSignal("Kick1"):Connect(function()
			KickSound:Play()
			if player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value < 92 then
				player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value+=10
			end
		end)
		animation:GetMarkerReachedSignal("Kick2"):Connect(function()
			KickSound:Play()
			if player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value < 92 then
				player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value+=10
			end
		end)
		animation:GetMarkerReachedSignal("Punch1"):Connect(function()
			PunchSound:Play()
			if player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value < 92 then
				player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value+=10
			end
		end)
		animation:GetMarkerReachedSignal("RotationKick"):Connect(function()
			KickSound:Play()
			if player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value < 92 then
				player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value+=10
			end
		end)
		animation:GetMarkerReachedSignal("Smashing"):Connect(function()
			SmashingSound:Play()
			if player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value < 92 then
				player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value+=10
			end
		end)
			
			
		task.delay(1.4,function()
			player.Character.HumanoidRootPart.Anchored = false
			task.wait(0.5)
			Stand.StandFollowing.Value = true
			task.wait(0.5)
			Stand.IsAttacking.Value = false
		end)
	end,
	
	
	
	AttackUlt = function(player,Stand)
		player.PlayerGui.Attacks.Ult.Charging.PercentCharged.Value = -1
		game.SoundService.UltUsing:Play()
		local PlayerAnimation = player.Character.Humanoid.Animator:LoadAnimation(game.ReplicatedStorage.Animations.PlayerAttackUlt)
		local CrashSound = Stand.Sounds.CrashingAttackUlt
		local Smashing2Sound = Stand.Sounds.Smashing2AttackUlt
		local animation = Stand.Humanoid.Animator:loadAnimation(game.ReplicatedStorage.Animations.AttackUltStand) 
        Stand.IsAttacking.Value = true
		Stand.StandFollowing.Value = false
		task.wait(0.11)

		--TweenService
		local TweenService = game:GetService("TweenService")
		local TweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
		local goal = {
			CFrame=player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(5,0,-20))
		}

		local Tween = TweenService:Create(Stand.HumanoidRootPart, TweenInfo, goal)
		player.Character.HumanoidRootPart.Anchored = true
		Tween:Play()

		--Animation 
		PlayerAnimation:Play()
		task.delay(0.2,function()
			animation:Play()
			animation:GetMarkerReachedSignal("Attack1"):Connect(function()
				CrashSound:Play()
			end)
			animation:GetMarkerReachedSignal("Attack3"):Connect(function()
				Smashing2Sound:Play()
			end)
		end)
		
		task.delay(1.7,function()
			player.Character.HumanoidRootPart.Anchored = false
			task.wait(0.5)
			Stand.StandFollowing.Value = true
			task.wait(0.5)
			Stand.IsAttacking.Value = false
		end)
	end,
	
}
return module
