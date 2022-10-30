module ShowSvgHelper
  def show_svg(path, classes = "")
    content = File.open("app/assets/images/#{path}", "rb") do |file|
      content = file.read
      unless classes.empty?
        content.sub! /<svg[^>]+>/ do |svg_tag|
          "#{svg_tag.chop} class=\"#{classes}\">"
        end
      end
    end
    raw content
  end
end
