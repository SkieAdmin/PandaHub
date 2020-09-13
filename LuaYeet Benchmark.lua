-- "I hereby put all Lua/LuaJIT tests and benchmarks that I wrote under the public domain." Mike Pall
-- https://github.com/LuaJIT/LuaJIT-test-cleanup

bit = bit32


local benchmarks = {

{Name="Array3d",
Func= function()
local function array_set(self, x, y, z, p)
  assert(x >= 0 and x < self.nx, "x outside PA")
  assert(y >= 0 and y < self.ny, "y outside PA")
  assert(z >= 0 and z < self.nz, "z outside PA")
  local pos = (z*self.ny + y)*self.nx + x
  local image = self.image
  if self.packed then
    local maxv = self.max_voltage
    if p > maxv then self.max_voltage = p*2.0 end
    local oldp = image[pos] or 0.0 -- Works with uninitialized table, too
    if oldp > maxv then p = p + maxv*2.0 end
    image[pos] = p
  else
    image[pos] = p
  end
  self.changed = true
  self.changed_recently = true
end

local function array_points(self)
  local y, z = 0, 0
  return function(self, x)
    x = x + 1
    if x >= self.nx then
      x = 0
      y = y + 1
      if y >= self.ny then
	y = 0
	z = z + 1
	if z >= self.nz then
	  return nil, nil, nil
	end
      end
    end
    return x, y, z
  end, self, 0
end

local function array_new(nx, ny, nz, packed)
  return {
    nx = nx, ny = ny, nz = nz,
    packed = packed, max_voltage = 0.0,
    changed = false, changed_recently = false,
    image = {}, -- Preferably use a fixed-type, pre-sized array here.
    set = array_set,
    points = array_points,
  }
end

local packed = true   -- Packed image or flat

local function run_iter(scaling)
  local dim = scaling -- Array dimension dim^3
  local arr = array_new(dim, dim, dim, packed)
  for x,y,z in arr:points() do
    arr:set(x, y, z, x*x)
  end
  assert(arr.image[dim^3-1] == (dim-1)^2)
end

return run_iter(200)
end


},

{
	Name="binarytrees",
	Func= function()
	local MIN_DEPTH = 4
local MAX_DEPTH = 12
local EXPECT_CKSUM = -10914

local function BottomUpTree(item, depth)
  if depth > 0 then
    local i = item + item
    depth = depth - 1
    local left, right = BottomUpTree(i-1, depth), BottomUpTree(i, depth)
    return { item, left, right }
  else
    return { item } -- Faster for LuaJIT: return { item, false }
  end
end

local function ItemCheck(tree)
  if #tree == 3 then -- Faster for LuaJIT: if tree[2] then
    return tree[1] + ItemCheck(tree[2]) - ItemCheck(tree[3])
  else
    return tree[1]
  end
end

local function inner_iter(mindepth, maxdepth)
    local check = 0

	do
	  local stretchdepth = maxdepth + 1
	  local stretchtree = BottomUpTree(0, stretchdepth)
	  check = check +ItemCheck(stretchtree)
	end

	local longlivedtree = BottomUpTree(0, maxdepth)

	for depth=mindepth,maxdepth,2 do
	  local iterations = 2 ^ (maxdepth - depth + mindepth)
	  for i=1,iterations do
	    check = check + ItemCheck(BottomUpTree(1, depth)) +
		    ItemCheck(BottomUpTree(-1, depth))
	  end
	end

	check = check + ItemCheck(longlivedtree)

    if check ~= EXPECT_CKSUM then
        puts("bad checksum: " .. checksum .. " vs " .. EXPECT_CKSUM)
        os.exit(1)
    end
end

local function run_iter(n)
    local i
    for i=1,n do
        inner_iter(MIN_DEPTH, MAX_DEPTH)
    end
end

return run_iter(3)
	end
	
	
},


{
	Name="coroutines",
	Func= function()
	local poolsize  = 503
local threads   = {}

-- cache these to avoid global environment lookups
local create    = coroutine.create
local resume    = coroutine.resume
local yield     = coroutine.yield

local id        = 1
local token     = 0
local ok

local body = function(token)
  while true do
    token = yield(token + 1)
  end
end

-- create all threads
for id = 1, poolsize do
  threads[id] = create(body)
end

local function run_iter(n)
  id        = 1
  token     = 0
  
  -- send the token
  repeat
  if id == poolsize then
    id = 1
  else
    id = id + 1
  end
  ok, token = resume(threads[id], token)
  until token == n
end

return run_iter(3300000)
	end

},

{
Name="euler",
Func= function()

--if not bit then
--bit = require("bit")
--end

local bnot, bor, band = bit.bnot, bit.bor, bit.band
local shl, shr = bit.lshift, bit.rshift

function run_iter(N)
  local cache, m, n = { 1 }, 1, 1
  for i=2,N do
    local j = i
    for len=1,1000000000 do
      j = bit32.bor(bit32.band(bit32.rshift(j,1), bit32.band(j,1)-1), bit32.band(bit32.lshift(j,1)+j+1, bit32.bnot(bit32.band(j,1)-1)))
      if cache then
        local x = cache[j]; if x then j = x+len; break end
      elseif j == 1 then
        j = len+1; break
      end
    end
    if cache then cache[i] = j end
    if j > m then m, n = j, i end
  end
  assert(m > 1 and n > 1)
end

return run_iter(3500000)
	end
}
}

print("[Panda Benchmarker]: Running benchmarks...")
print("[Panda Benchmarker]: ----------------------------------------------- ")
local function getTime() 
	if tick then
		return tick()
	else
		return os.clock()
	end
end


for _,v in pairs(benchmarks) do
	local start = getTime() 
	print("	[+]: Running benchmark '" .. v.Name .. "'...")
	
	local v, msg = pcall(function()
	v.Func()
	end)
	
	
	if not v then
	print("	[+]: Benchmark failed, YOUR EXPLOIT IS GAY")
	 else

	local endT = getTime() 
	print("	[+]: Benchmark finished in " .. (endT - start) .. "\n")
	end
	
	

	
	
end