
local json = require "json"

node.alias "input-example"
local x = 0

local dir = 1
gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

gesture = 0
gesture_detected = 1

local function get_gesture()

	local function handle_event(ev)
		gesture = ev.value
		--print(gesture)
	end

	util.data_mapper{
        	["event"] = function(data)
        		handle_event(json.decode(data))
        end
    	}
end

get_gesture()

-- creating pictures table
local pictures = util.generator(function()
    local out = {}
    for name, _ in pairs(CONTENTS) do
        if name:match(".*JPG") then
            out[#out + 1] = name
        end
    end
    table.sort(out)
    return out
end)

-- removing pictures from table
node.event("content_remove", function(filename)
    pictures:remove(filename)
end)

-- find previous picture
function pictures.previous(image)
	local s = nil 
	local slika = nil

	while 1 do
		s = pictures.next()
		if ( s == image ) then
			return slika
		end
		slika = s
	end
end	


local next_image
local next_image_time = sys.now() + 99

local image_name = pictures.previous("gesture_instructions.JPG")
local left_image = resource.load_image(image_name)
--print(image_name)

local current_image = resource.load_image("gesture_instructions.JPG")


image_name = pictures.next()
local right_image = resource.load_image(image_name)
--print(image_name)



function node.render()
	gl.clear(0,0,0,1)
	gl.perspective(60,WIDTH/2, HEIGHT/2, -WIDTH/1.6,WIDTH/2, HEIGHT/2, 0)

	local time_to_next = next_image_time - sys.now() --get relative spent time
    
	if gesture_detected == 1 then --flag for detected gestur
		if time_to_next < 0 then
			
			next_image_time = sys.now() + 9999	
			print("gesture detected")
			gesture_detected = 1
			if dir == 1 then -- left
				left_image:dispose()
				left_image = current_image
				current_image = right_image
				--next_image = right_image
				right_image = nil
				image_name = pictures.previous(image_name)
				print (image_name)
      		 		right_image = resource.load_image(image_name)
				util.draw_correct(current_image, 0,0,WIDTH,HEIGHT) --dunno why
			end
	
			if dir == -1 then -- right
				image_name = pictures.next() 
       	 			right_image:dispose()
       	 			right_image = current_image
       	     			current_image = left_image
				--next_image = left_image
            			left_image = nil
	    			print (image_name)
            			left_image = resource.load_image(image_name)
				util.draw_correct(current_image, 0,0,WIDTH,HEIGHT) --dunno why
			end
		--	util.draw_correct(next_image, 0,0,WIDTH,HEIGHT) --dunno why

		elseif time_to_next < 0.5 then
		--	elseif time_to_next < 1 then
			local xoff = (0.5 - time_to_next) * WIDTH * 2

        	-- [amimation] push current image to the side off the display
			gl.pushMatrix()
				util.draw_correct(current_image	, (xoff * dir), 0, WIDTH + (xoff*dir), HEIGHT)
     		   	gl.popMatrix()

	        -- [animation] push next image to the center of the screen
        		gl.pushMatrix()
            			--xoff = (time_to_next*dir) - WIDTH
				if dir == -1 then -- gesture right
            				util.draw_correct(left_image,  WIDTH - (xoff), 0, 2 * WIDTH - (xoff), HEIGHT )
        			elseif dir == 1 then -- gesture left
					util.draw_correct(right_image,  - WIDTH + (xoff*dir), 0, 0 + (xoff*dir), HEIGHT )	
				end
			gl.popMatrix()


		
    		else
        		util.draw_correct(current_image, 0,0,WIDTH,HEIGHT)
    		end
	
	end


    	x = x + 1
    	if x > 1 then
		--print("time")
		--print(next_image_time)
		if gesture == 2 then
			dir = 1 -- desno
			gesture = 0
			next_image_time = sys.now() + 0.6
			gesture_detected = 1
		elseif gesture == 3 then
			dir = -1 -- levo
			gesture = 0
			next_image_time = sys.now() + 0.6
			gesture_detected = 1
		end

		x = 0
    	end

end
