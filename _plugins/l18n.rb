module Jekyll
  @parsedlangs = {}
  def self.langs
    @parsedlangs
  end
  def self.setlangs(l)
    @parsedlangs = l
  end
  class Site
    attr_reader :currentlang, :defaultlang

    alias :process_org :process
    def process
      if !self.config['baseurl']
        self.config['baseurl'] = ""
      end
      #Variables
      config['baseurl_root'] = self.config['baseurl']
      baseurl_org = self.config['baseurl']
      languages = self.config['languages']
      exclude_org = self.exclude
      dest_org = self.dest

      #Loop
      @currentlang = @defaultlang = self.config['lang'] = self.config['default_lang'] = languages.first
      puts
      puts "Building site for default language: \"#{self.config['lang']}\" to: #{self.dest}"
      process_org
      languages.drop(1).each do |lang|
        @currentlang = lang;

        # Build site for language lang
        @dest = @dest + "/" + lang
        self.config['baseurl'] = self.config['baseurl'] + "/" + lang
        self.config['lang'] = lang

        # exclude folders or files from being copied to all the language folders
        exclude_from_localizations = self.config['exclude_from_localizations'] || []
        @exclude = @exclude + exclude_from_localizations

        puts "Building site for language: \"#{self.config['lang']}\" to: #{self.dest}"
        process_org

        #Reset variables for next language
        @dest = dest_org
        @exclude = exclude_org

        self.config['baseurl'] = baseurl_org
      end
      Jekyll.setlangs({})
      puts 'Build complete'
    end

    # alias :read_posts_org :read_posts
    # def read_posts(dir)
    #   translate_posts = !self.config['exclude_from_localizations'].include?("_posts")
    #   if dir == '' && translate_posts
    #     read_posts("_i18n/#{self.config['lang']}/")
    #   else
    #     read_posts_org(dir)
    #   end
    # end
  end

  # class Document
  #   # The full path to the output file.
  #   #
  #   # base_directory - the base path of the output directory
  #   #
  #   # Returns the full path to the output file of this document.
  #   def destination(base_directory)
  #     dest = site.in_dest_dir(base_directory)
  #     url_for_i18n = url.sub(/\/_i18n\/\D{2}/, "")
  #     path = site.in_dest_dir(dest, URL.unescape_path(url_for_i18n))
  #     path = File.join(path, "index.html") if url.end_with?("/")
  #     path << output_ext unless path.end_with?(output_ext)
  #     path
  #   end
  # end

  class URL
    def to_s
      sanitize_url(generated_permalink || generated_url).sub(/\/_i18n\/\D{2}/, "")
    end
  end

  class Reader
    alias :retrieve_posts_org :retrieve_posts
    def retrieve_posts(dir)
      translate_posts = !@site.config['exclude_from_localizations'].include?("_posts")
      default_lang = @site.currentlang == @site.defaultlang;

      if(!default_lang)
        dir = "_i18n/#{@site.config['lang']}"
      end

      retrieve_posts_org(dir)
      # if default_lang
      #   retrieve_posts_org(dir)
      # else
      #   retrieve_posts_org("_i18n/#{@site.config['lang']}/#{dir}")
      # end

      # if dir == '' && translate_posts
      #   read_posts("_i18n/#{@site.config['lang']}/")
      # else
      #   read_posts_org(dir)
      # end
    end
  end

=begin
  class Reader
    alias :retrieve_posts_org :retrieve_posts
    def retrieve_posts(dir)
      translate_posts = !@site.config['exclude_from_localizations'].include?("_posts")
      default_lang = @site.currentlang == @site.defaultlang;
      if default_lang
        retrieve_posts_org(dir)
      else
        retrieve_posts_org("#{@site.config['lang']}/" + dir)
      end
    end
  end
=end

  class Page
    def permalink
      return nil if data.nil? || data['permalink'].nil?
      if site.config['relative_permalinks']
        File.join(@dir, data['permalink'])
      else
        # Look if there's a permalink overwrite specified for this lang
        data['permalink_'+site.config['lang']] || data['permalink']
      end
    end
  end

  class Document
    def categories_from_path(special_dir)
      languages = @site.config["languages"];
      superdirs = relative_path.sub(/#{special_dir}(.*)/, '').split(File::SEPARATOR)
      superdirs = superdirs.reject do |c|
        c.empty? || c.eql?(special_dir) || c.eql?(basename) || (languages.include? c) || c == "_i18n"
      end
      merge_data!({ 'categories' => superdirs })
    end
  end

  class LocalizeTag < Liquid::Tag

    def initialize(tag_name, key, tokens)
      super
      @key = key.strip
    end

    def render(context)
      if "#{context[@key]}" != "" #Check for page variable
        key = "#{context[@key]}"
      else
        key = @key
      end
      lang = context.registers[:site].config['lang']
      unless Jekyll.langs.has_key?(lang)
        puts "Loading translation from file #{context.registers[:site].source}/_i18n/#{lang}.yml"
        Jekyll.langs[lang] = YAML.load_file("#{context.registers[:site].source}/_i18n/#{lang}.yml")
      end
      translation = Jekyll.langs[lang].access(key) if key.is_a?(String)
      if translation.nil? or translation.empty?
        translation = Jekyll.langs[context.registers[:site].config['default_lang']].access(key)
        puts "Missing i18n key: #{lang}:#{key}"
        puts "Using translation '%s' from default language: %s" %[translation, context.registers[:site].config['default_lang']]
      end
      translation
    end
  end

  module Tags
    class LocalizeInclude < IncludeTag
      def render(context)
        if "#{context[@file]}" != "" #Check for page variable
          file = "#{context[@file]}"
        else
          file = @file
        end

        includes_dir = File.join(context.registers[:site].source, '_i18n/' + context.registers[:site].config['lang'])

        if File.symlink?(includes_dir)
          return "Includes directory '#{includes_dir}' cannot be a symlink"
        end
        if file !~ /^[a-zA-Z0-9_\/\.-]+$/ || file =~ /\.\// || file =~ /\/\./
          return "Include file '#{file}' contains invalid characters or sequences"
        end

        Dir.chdir(includes_dir) do
          choices = Dir['**/*'].reject { |x| File.symlink?(x) }
          if choices.include?(file)
            source = File.read(file)
            partial = Liquid::Template.parse(source)

            context.stack do
              context['include'] = parse_params(context) if @params
              contents = partial.render(context)
              site = context.registers[:site]
              ext = File.extname(file)

              converter = site.converters.find { |c| c.matches(ext) }
              contents = converter.convert(contents) unless converter.nil?

              contents
            end
          else
            "Included file '#{file}' not found in #{includes_dir} directory"
          end
        end
      end
    end
  end

  class LocalizeLink < Liquid::Tag

    def initialize(tag_name, key, tokens)
      super
      @key = key
    end

    def render(context)
      if "#{context[@key]}" != "" #Check for page variable
        key = "#{context[@key]}"
      else
        key = @key
      end
      key = key.split
      namespace = key[0]
      lang = key[1] || context.registers[:site].config['lang']
      default_lang = context.registers[:site].config['default_lang']
      baseurl = context.registers[:site].baseurl
      pages = context.registers[:site].pages
      url = "";

      if default_lang != lang
        baseurl = baseurl + "/" + lang
      end

      for p in pages
        unless p['namespace'].nil?
          page_namespace = p['namespace']
          if namespace == page_namespace
            permalink = p['permalink_'+lang] || p['permalink']
            url = baseurl + permalink
          end
        end
      end
      url
    end
  end
end

unless Hash.method_defined? :access
  class Hash
    def access(path)
      ret = self
      path.split('.').each do |p|
        if p.to_i.to_s == p
          ret = ret[p.to_i]
        else
          ret = ret[p.to_s] || ret[p.to_sym]
        end
        break unless ret
      end
      ret
    end
  end
end

Liquid::Template.register_tag('t', Jekyll::LocalizeTag)
Liquid::Template.register_tag('translate', Jekyll::LocalizeTag)
Liquid::Template.register_tag('tf', Jekyll::Tags::LocalizeInclude)
Liquid::Template.register_tag('translate_file', Jekyll::Tags::LocalizeInclude)
Liquid::Template.register_tag('tl', Jekyll::LocalizeLink)
Liquid::Template.register_tag('translate_link', Jekyll::LocalizeLink)

module Jekyll
  module Filters
    def date_to_string(date)
      config = @context.registers[:site].config
      if config["lang"] == "en"
        time(date).strftime("%d %b %Y")
      else
        strftime_tr(date, "%d %b %Y")
      end
    end

    def strftime_tr(date, format)
      t = time(date)
      abbr_monthnames = [nil] + %w(Oca Şub Mar Nis May Haz Tem Ağu Eyl Eki Kas Ara)
      format.gsub!(/%b/, abbr_monthnames[t.mon])
      t.strftime(format)
    end
  end
end
