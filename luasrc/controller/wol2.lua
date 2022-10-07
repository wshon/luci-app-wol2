module("luci.controller.wol2", package.seeall)
local t, a
local x = luci.model.uci.cursor()

function index()
    if not nixio.fs.access("/etc/config/wol2") then return end
    entry({"admin", "services", "wol2"}, cbi("wol2"), _("wol2"), 95).dependent = true
	entry( {"admin", "services", "wol2", "awake"}, post("awake") ).leaf = true
end

function awake(sections)
	lan = x:get("wol2",sections,"maceth")
	mac = x:get("wol2",sections,"macaddr")
    local e = {}
    cmd = "/usr/bin/etherwake -D -i " .. lan .. " -b " .. mac .. " 2>&1"
	local p = io.popen(cmd)
	local msg = ""
	if p then
		while true do
			local l = p:read("*l")
			if l then
				if #l > 100 then l = l:sub(1, 100) .. "..." end
				msg = msg .. l
			else
				break
			end
		end
		p:close()
	end
	e["data"] = msg
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end
