extends Node;

func LoadAudio(path: String):
	return audio_streams[path];
func LoadImage(path: String):
	return images[path];
func LoadFonts(path: String):
	return fonts[path];
func __index(ref : LuaAPI, index) :
	match (index) :
		"LoadAudio" :
			return LoadAudio;
		"LoadImage" :
			return LoadImage;
		"LoadFonts" :
			return LoadFonts;

var source_path:String = LuaGlobal.game_file_dir;
var images = {}; # 图像资源位置
var audio_streams = {}; # 音频资源
var scripts = {}; # 脚本资源
var fonts = {}; # 字体资源
 
func _ready():
	if (!DirAccess.dir_exists_absolute(source_path)) :
		print("ERROR");
		get_window().free();
	load_sprites(); # 加载图片
	load_audios();
	load_scripts();
	load_fonts();

func load_fonts():
	var font_names:PackedStringArray = _load_filenames("", ["TTF","OTF","WOFF","WOFF2","PFB","PFM"]);
	for fnt_path in font_names :
		var font_file = FontFile.new();
		font_file.load_dynamic_font(source_path + "/" + fnt_path);
		fonts[fnt_path] = font_file;
		pass;

func load_audios():
	var audio_names:PackedStringArray = _load_filenames("", ["OGG","WAV","MP3"]);
	for aud_path in audio_names :
		var ext = aud_path.get_extension().to_upper();
		var file = FileAccess.open(source_path + "/" + aud_path, FileAccess.READ);
		if (!file) :
			continue;
		var stream:AudioStream;
		match (ext) :
			"OGG":
				stream = AudioStreamOggVorbis.load_from_buffer(file.get_buffer(file.get_length()));
			"WAV":
				stream = AudioStreamWAV.new();
				var data:PackedByteArray = file.get_buffer(file.get_length());
				if (data.size() < 40) :
					print("加载 " + aud_path + " 时出错");
					continue;
				stream.mix_rate = data.decode_u16(24);
				var format = data.decode_u16(34);
				stream.stereo = (data.decode_u16(22) == 2);
				match (format) :
					8:
						stream.format = AudioStreamWAV.FORMAT_8_BITS;
					16:
						stream.format = AudioStreamWAV.FORMAT_16_BITS;
					_:
						continue;
				stream.data = data;
			"MP3":
				stream = AudioStreamMP3.new();
				stream.data = file.get_buffer(file.get_length());
			_: 
				file.close();
				continue;
		audio_streams[aud_path] = stream;
		file.close();

func load_scripts():
	var script_names:PackedStringArray = _load_filenames("", ["LUA"]);
	for scr_path in script_names :
		var file = FileAccess.open(source_path + "/" + scr_path, FileAccess.READ);
		if (file != null):
			scripts[scr_path] = file.get_buffer(file.get_length()).get_string_from_utf8();
			file.close();

func load_sprites():
	var sprite_names:PackedStringArray = _load_filenames("", ["PNG","JPG","JPEG","WEBP","BMP","TGA"]);
	for spr_path in sprite_names :
		var ext = spr_path.get_extension().to_upper();
		var file = FileAccess.open(source_path + "/" + spr_path, FileAccess.READ);
		var img = Image.new();
		match (ext) :
			"PNG": img.load_png_from_buffer(file.get_buffer(file.get_length()));
			"JPG": img.load_jpg_from_buffer(file.get_buffer(file.get_length()));
			"JPEG": img.load_jpg_from_buffer(file.get_buffer(file.get_length()));
			"WEBP": img.load_webp_from_buffer(file.get_buffer(file.get_length()));
			"BMP": img.load_bmp_from_buffer(file.get_buffer(file.get_length()));
			"TGA": img.load_tga_from_buffer(file.get_buffer(file.get_length()));
			_: 
				file.close();
				continue;
		file.close();
		if (img.is_empty()) :
			print("加载 " + spr_path + " 时出错");
			continue;
		else :
			var img_t:ImageTexture = ImageTexture.create_from_image(img);
			images[spr_path] = img_t;

func _load_filenames(path = "",filters:Array[String] = []) -> PackedStringArray:
	var dir_access = DirAccess.open(source_path + "/"+ path);
	if (dir_access == null) :
		return [];
	var files:PackedStringArray = [];
	dir_access.list_dir_begin();
	var file_name:String = dir_access.get_next();
	var file_ext:String = "";
	while(file_name != ""):
		if (dir_access.current_is_dir()) :
			var f_local_p = ((path+"/")if(!path.is_empty())else("")) + file_name;
			files += _load_filenames(f_local_p, filters);
		else :
			file_ext = file_name.get_extension().to_upper();
			if (filters.has(file_ext)) :
				files.push_back(path + file_name);
		file_name = dir_access.get_next();
	dir_access.list_dir_end();
	return files;
