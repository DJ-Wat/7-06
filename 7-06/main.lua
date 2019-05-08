-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Gravity



local physics = require( "physics" )



physics.start()

physics.setGravity( 0, 25 ) -- ( x, y )

physics.setDrawMode( "hybrid" )   -- Shows collision engine outlines only



local playerBullets = {} -- Table that holds the players Bullets



local leftWall = display.newRect( 0, display.contentHeight / 2, 1, display.contentHeight )

-- myRectangle.strokeWidth = 3

-- myRectangle:setFillColor( 0.5 )

-- myRectangle:setStrokeColor( 1, 0, 0 )

leftWall.alpha = 0.0

physics.addBody( leftWall, "static", { 

    friction = 0.5, 

    bounce = 0.3 

    } )



local theGround1 = display.newImageRect( "./assets/sprites/land.png", 500, 100)

theGround1.x = 20

theGround1.y = display.contentHeight

theGround1.id = "the ground"

physics.addBody( theGround1, "static", { 

    friction = 0.5, 

    bounce = 0.3 

    } )



local theGround2 = display.newImageRect( "./assets/sprites/land.png", 500, 100 )

theGround2.x = 520

theGround2.y = display.contentHeight

theGround2.id = "the ground" -- notice I called this the same thing

physics.addBody( theGround2, "static", { 

    friction = 0.5, 

    bounce = 0.3 

    } )



local landSquare = display.newImageRect( "./assets/sprites/landSquare.png", 150,150)

landSquare.x = 420

landSquare.y = display.contentHeight - 1000

landSquare.id = "land Square"

physics.addBody( landSquare, "dynamic", { 

    friction = 0.5, 

    bounce = 0.3 

    } )



local theCharacter = display.newImageRect( "./assets/sprites/Idle.png", 100, 200)

theCharacter.x = display.contentCenterX - 200

theCharacter.y = display.contentCenterY

theCharacter.id = "the character"

physics.addBody( theCharacter, "dynamic", { 

    density = 3.0, 

    friction = 0.5, 

    bounce = 0.3 

    } )

theCharacter.isFixedRotation = true -- If you apply this property before the physics.addBody() command for the object, it will merely be treated as a property of the object like any other custom property and, in that case, it will not cause any physical change in terms of locking rotation.



local dPad = display.newImage( "./assets/sprites/d-pad.png" )

dPad.x = 150

dPad.y = display.contentHeight - 80

dPad.alpha = 0.50

dPad.id = "d-pad"



local upArrow = display.newImage( "./assets/sprites/upArrow.png" )

upArrow.x = 150

upArrow.y = display.contentHeight - 190

upArrow.id = "up arrow"



local downArrow = display.newImage( "./assets/sprites/downArrow.png" )

downArrow.x = 150

downArrow.y = display.contentHeight + 28

downArrow.id = "down arrow"



local leftArrow = display.newImage( "./assets/sprites/leftArrow.png" )

leftArrow.x = 40

leftArrow.y = display.contentHeight - 80

leftArrow.id = "left arrow"



local rightArrow = display.newImage( "./assets/sprites/rightArrow.png" )

rightArrow.x = 260

rightArrow.y = display.contentHeight - 80

rightArrow.id = "right arrow"



local jumpButton = display.newImage( "./assets/sprites/jumpButton.png" )

jumpButton.x = display.contentWidth - 80

jumpButton.y = display.contentHeight - 250

jumpButton.id = "jump button"

jumpButton.alpha = 0.5



local shootButton = display.newImage( "./assets/sprites/jumpButton.png" )

shootButton.x = display.contentWidth - 250

shootButton.y = display.contentHeight - 250

shootButton.id = "shootButton"

shootButton.alpha = 0.5

 

local function characterCollision( self, event )

 

    if ( event.phase == "began" ) then

        print( self.id .. ": collision began with " .. event.other.id )

 

    elseif ( event.phase == "ended" ) then

        print( self.id .. ": collision ended with " .. event.other.id )

    end

end



function checkPlayerBulletsOutOfBounds()

	-- check if any bullets have gone off the screen

	local bulletCounter



    if #playerBullets > 0 then

        for bulletCounter = #playerBullets, 1 ,-1 do

            if playerBullets[bulletCounter].x > display.contentWidth + 1000 then

                playerBullets[bulletCounter]:removeSelf()

                playerBullets[bulletCounter] = nil

                table.remove(playerBullets, bulletCounter)

                print("remove bullet")

            end

        end

    end

end



function upArrow:touch( event )

    if ( event.phase == "ended" ) then

        -- move the character up

        transition.moveBy( theCharacter, { 

        	x = 0, -- move 0 in the x direction 

        	y = -50, -- move up 50 pixels

        	time = 100 -- move in a 1/10 of a second

        	} )

    end



    return true

end



function downArrow:touch( event )

    if ( event.phase == "ended" ) then

        -- move the character up

        transition.moveBy( theCharacter, { 

        	x = 0, -- move 0 in the x direction 

        	y = 50, -- move up 50 pixels

        	time = 100 -- move in a 1/10 of a second

        	} )

    end



    return true

end



function leftArrow:touch( event )

    if ( event.phase == "ended" ) then

        -- move the character up

        transition.moveBy( theCharacter, { 

        	x = -50, -- move 0 in the x direction 

        	y = 0, -- move up 50 pixels

        	time = 100 -- move in a 1/10 of a second

        	} )

    end



    return true

end



function rightArrow:touch( event )

    if ( event.phase == "ended" ) then

        -- move the character up

        transition.moveBy( theCharacter, { 

        	x = 50, -- move 0 in the x direction 

        	y = 0, -- move up 50 pixels

        	time = 100 -- move in a 1/10 of a second

        	} )

    end



    return true

end



function jumpButton:touch( event )

    if ( event.phase == "ended" ) then

        -- make the character jump

        theCharacter:setLinearVelocity( 0, -750 )

    end



    return true

end



function shootButton:touch( event )

    if ( event.phase == "began" ) then

        -- make a bullet appear

        local aSingleBullet = display.newImage( "./assets/sprites/Kunai.png" )

        aSingleBullet.x = theCharacter.x + 100

        aSingleBullet.y = theCharacter.y

        physics.addBody( aSingleBullet, 'dynamic' )

        -- Make the object a "bullet" type object

        aSingleBullet.isBullet = true

        aSingleBullet.gravityScale = 0

        aSingleBullet.id = "bullet"

        aSingleBullet:setLinearVelocity( 1500, 0 )



        table.insert(playerBullets,aSingleBullet)

        print("# of bullet: " .. tostring(#playerBullets))

    end



    return true

end



-- if character falls off the end of the world, respawn back to where it came from

function checkCharacterPosition( event )

    -- check every frame to see if character has fallen

    if theCharacter.y > display.contentHeight + 500 then

        theCharacter.x = display.contentCenterX - 200

        theCharacter.y = display.contentCenterY

    end

end





upArrow:addEventListener( "touch", upArrow )

downArrow:addEventListener( "touch", downArrow )

leftArrow:addEventListener( "touch", leftArrow )

rightArrow:addEventListener( "touch", rightArrow )



jumpButton:addEventListener( "touch", jumpButton )

shootButton:addEventListener( "touch", shootButton )



Runtime:addEventListener( "enterFrame", checkCharacterPosition )

Runtime:addEventListener( "enterFrame", checkPlayerBulletsOutOfBounds )