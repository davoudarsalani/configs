-- by me


local ya_target_family = ya.target_family()  -- unix

-- ------------------------------------
-- for full-border plugin
require("full-border"):setup()

-- ------------------------------------
-- Show user/group of files in status bar
-- https://yazi-rs.github.io/docs/tips/#user-group-in-status

Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya_target_family ~= "unix" then
		return ""
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("white"),
		ui.Span(":"):fg("blue"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("white"),
		" ",
	}
end, 500, Status.RIGHT)

-- ------------------------------------
-- Show symlink in status bar
-- https://yazi-rs.github.io/docs/tips/#symlink-in-status

Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)

-- ------------------------------------
-- Show username and hostname in header
-- https://yazi-rs.github.io/docs/tips/#username-hostname-in-header

Header:children_add(function()
	if ya_target_family ~= "unix" then
		return ""
	end
	return ui.Line {
		ui.Span(ya.user_name()):fg("white"),
		ui.Span("@"):fg("blue"),
		ui.Span(ya.host_name()):fg("white"),
		":",
	}
end, 500, Header.LEFT)
