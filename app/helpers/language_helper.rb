module LanguageHelper
  def other_language_link
    if I18n.locale == :pl
      link_to image_tag("en-flag.png", size: "30x25"), change_language_path({locale: :en}), class: "language-image"
    else
      link_to image_tag("pl-flag.png", size: "30x25"), change_language_path({locale: :pl}), class: "language-image"
    end
  end
end
