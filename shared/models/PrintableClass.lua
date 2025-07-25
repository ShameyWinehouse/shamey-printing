---@class Printable
Printable = {}

Printable.id = 0
Printable.type = nil
Printable.pressId = nil
Printable.title = nil
Printable.description = nil
Printable.countPrinted = 0
Printable.dateCreated = nil
Printable.publisher = nil

function Printable:getId()
	return self.id
end

function Printable:setId(id)
	self.id = id
end

function Printable:getType()
	return self.type
end

function Printable:setType(type)
	self.type = type
end

function Printable:getPressId()
	return self.pressId
end

function Printable:setPressId(pressId)
	self.pressId = pressId
end

function Printable:getTitle()
	return self.title
end

function Printable:setTitle(title)
	self.title = title
end

function Printable:getDescription()
	return self.description
end

function Printable:setDescription(description)
	self.description = description
end

function Printable:getCountPrinted()
	return self.countPrinted
end

function Printable:setCountPrinted(countPrinted)
	self.countPrinted = countPrinted
end

function Printable:getDateCreated()
	return self.dateCreated
end

function Printable:setDateCreated(dateCreated)
	self.dateCreated = dateCreated
end

function Printable:getPublisher()
	return self.publisher
end

function Printable:setPublisher(publisher)
	self.publisher = publisher
end



---@return Printable
function Printable:New(t)
	t = t or {}
	setmetatable(t, self)
	self.__index = self
	return t
end