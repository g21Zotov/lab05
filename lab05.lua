#!/usr/bin/lua5.1

lgi = require 'lgi'

gtk = lgi.require ("Gtk","3.0")
pixbuf = lgi.GdkPixbuf.Pixbuf

gtk.init()

bld = gtk.Builder()
bld:add_from_file('lab05.glade')

ui = bld.objects

function ui.btn_add:on_clicked(...)
	name = ui.txt_name.text
	value = tonumber(ui.txt_value.text)
	image = ui.txt_image.text
	
	px = pixbuf.new_from_file(image)
	
	i = ui.mdl_items:append()
	ui.mdl_items[i] = {[1] = name, [2] = value, [3] = px}
	
	file = io.open("lab05.txt", "a")
	io.output(file)
	io.write(name, tostring(value), image, " ")
	io.close(file)
end

rdr_txt = gtk.CellRendererText {}
rdr_pix = gtk.CellRendererPixbuf {}

c1 = gtk.TreeViewColumn { title = 'Name', {rdr_txt, { text = 1 }} }
c2 = gtk.TreeViewColumn { title = 'Value', {rdr_txt, { text = 2 }} }
c3 = gtk.TreeViewColumn { title = 'Image', {rdr_pix, { pixbuf = 3 }} }

ui.lst_items:append_column(c1)
ui.lst_items:append_column(c2)
ui.lst_items:append_column(c3)

ui.wnd.title = 'Zotov 21 lab05'
ui.wnd.on_destroy = gtk.main_quit
ui.wnd:show_all()

gtk.main()


