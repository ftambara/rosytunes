module ShowSvgHelper
  def show_svg(name, classes = [])
    svg = File.open("app/assets/images/#{name}", "rb") do |file|
      append_to_tag(file.read, class_attr(classes), "svg") unless classes.empty?
    end
    # Don't escape tags
    raw svg
  end

  private
    def class_attr(classes)
      %Q{class="#{classes.join(" ")}"}
    end

    def append_to_tag(source, appendage, tag)
      source.sub!(/<#{tag}[^>]+>/) do |element|
        "#{element.chop} #{appendage}\">"
      end
    end
end
