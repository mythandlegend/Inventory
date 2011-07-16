--------SAMPLE CODE - CORONASDK
-- AUTHOR: Jayant C Varma
-- Demonstration of an Inventory System
-- © 2011, OZ Apps
-- dev@oz-apps.com
--
--If you use the Code, write an email of thanks and send me a promo code of your game/app where you use it
--
-------------------------------------------

--This code is totally NON-GUI as the GUI can be varied by different apps in the way they manage the inventory.

local property=require("property")
local prop = property.init()

local items = {
"BLACK-BAG-icon.png",
"BLACK-GLASSES-icon.png",
"CHANEL-LOGO-icon.png",
"NECKLACE-icon.png",
"NO-5-icon.png",
"PINK-GLASSES-icon.png",
"PINK-SHOE-icon.png",
"SILVER-PURSE-icon.png",
"WATCH-icon.png",
"WHITE-SHOE-icon.png",
}
local slots = 5

--Because we have filenames, you can display these on the screen where ever you want

local inventoryBag={}	--The InventoryBag table holding everything in our inventory

local addItemToInventory, removeItemFromInventory, aveInventory, loadInventory, displayInventory
--The local functions that are used to manage Inventory


function addItemToInventory(itemIndex,inSlot, redraw)
 local itemIndex = itemIndex
 local inSlot = inSlot
 local iteminSlot = inventoryBag[inSlot]

 local redraw = redraw or false
	
 
 if inSlot > 5 or inSlot < 1  then return end
 
 if itemInSlot ~= nil then
 	removeFromInventory(itemIndex)
 end

 inventoryBag[inSlot] = itemIndex

	if redraw == true then 
		displayInventory()
	end
 
end

function removeItemFromInventory(itemIndex, redraw)
	local i
	
	local redraw = redraw or false
	
	for i=1,slots do
		if inventoryBag[i] ==itemIndex then
			inventoryBag[i]=0
		end
	end
	
	if redraw == true then 
		displayInventory()
	end
end

function saveInventory()
	local i,v
	for i=1,slots do
		--print("->",i,inventoryBag[i])
		
		prop:setProperty("Item"..i,inventoryBag[i])
	end
	
	prop:SaveToFile()
end

function loadInventory()
	local i
	for i=1,slots do
	 local returnVal = tonumber(prop:getProperty("Item"..i, 0))
	 --print("Got ", returnVal, "Had", inventoryBag[i])
	 inventoryBag[i] = returnVal
	end
end

function displayInventory()
	local i
	for i=1,slots do
		local itemInSlot = inventoryBag[i]
		--print("ItemInSlot",i,itemInSlot)
		if itemInSlot ~= nil or itemInSlot ~= 0 then
			print(i,items[itemInSlot])
		end
	end
end

print("Loading Inventory")
loadInventory()				--Load whatever we had in the inventory the last time

displayInventory()			--Display what the inventory looks like

addItemToInventory(3,1)		-- Add the Channel-Logo
addItemToInventory(6,2) 	-- Add the Pink-Glasses
addItemToInventory(2,4) 	-- Add the Black-Glasses
displayInventory()			-- Show what we have in our inventory
saveInventory()				-- Save the inventory to disk

addItemToInventory(7,2)		-- Overwrite the Pink-Glasses with Pink-Shoe
removeItemFromInventory(4)  -- Try to remove the Necklace which does not exist

displayInventory()			-- Show what the inventory is like
saveInventory()				-- Save the inventory to disk

removeItemFromInventory(2)	-- Remove the Black-Glasses from the inventory where ever it is

displayInventory()			--Display what the inventory looks like