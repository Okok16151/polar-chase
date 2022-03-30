local speed = 2
local counter = 0
local assets = {'sky', 'mountains', 'vans', 'ground'}
local followchars = true
local xx = 520
local yy = 600
local xx2 = 1300
local yy2 = 600
local snowo = false
local ofs = 50
local del = 0
local del2 = 0
local allowCountdown = false
local speed = 1

function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'brandon')
    for i = 1,4 do
        makeLuaSprite(assets[i], 'bg/'..assets[i], -800, -600)
        scaleObject(assets[i], 2.2, 2.2)
        addLuaSprite(assets[i], false)
    end
    setProperty('vans.x', -1050)
    setScrollFactor('sky', 0.2, 0.3)
    setScrollFactor('mountains', 0.6, 0.7)
    setScrollFactor('vans', 0.8, 1)

end

function  onCreatePost()
	speed = 240*2 / getPropertyFromClass('ClientPrefs', 'framerate')
	for i = 0,8 do
		local line = math.floor((i+1)/3 + 0.25)
		local x = - 1280 + i*1280 + line * (-1280*3)
		local y = line * 720 - 720

		makeLuaSprite('snow'..i, 'bg/snonw', x, y)
		setObjectCamera('snow'..i, 'camHud')
		addLuaSprite('snow'..i, true)

		snowo = true
	end
end

function onUpdate(elapsed)
	if snowo then
		if getProperty('snow0.x') >= 0 then
			for i = 0,8 do
				local line = math.floor((i+1)/3 + 0.25)
				local x = - 1280 + i*1280 + line * (-1280*3)
				local y = line * 720 - 720
	
				setProperty('snow'..i..'.x', x)
				setProperty('snow'..i..'.y', y)
	
				counter = 0
			end
		else
			for i = 0,8 do
				setProperty('snow'..i..'.x', getProperty('snow'..i..'.x')+1*1280/720*speed)
				setProperty('snow'..i..'.y', getProperty('snow'..i..'.y')+1*speed)
			end
		end
	end
    if followchars == true then
		if mustHitSection == false then
		  --setProperty('defaultCamZoom',0.7)
		  if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
			triggerEvent('Camera Follow Pos',xx-ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
			triggerEvent('Camera Follow Pos',xx+ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singUP' then
			triggerEvent('Camera Follow Pos',xx,yy-ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
			triggerEvent('Camera Follow Pos',xx,yy+ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
			triggerEvent('Camera Follow Pos',xx-ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
			triggerEvent('Camera Follow Pos',xx+ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
			triggerEvent('Camera Follow Pos',xx,yy-ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
			triggerEvent('Camera Follow Pos',xx,yy+ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
			triggerEvent('Camera Follow Pos',xx,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'idle' then
			triggerEvent('Camera Follow Pos',xx,yy)
		  end
		else
		  --setProperty('defaultCamZoom',0.6)
		  if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
			triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
			triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
			triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
			triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
			triggerEvent('Camera Follow Pos',xx2,yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			triggerEvent('Camera Follow Pos',xx2,yy2)
		  end
		end
	else
		triggerEvent('Camera Follow Pos','','')
	end
end

function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then
		startDialogue('dialogue');
	end
end