module ApplicationHelper
  STATUS_LABELS = {
    "active"   => "Активно",
    "closed"   => "Закрыто",
    "pending"  => "На рассмотрении",
    "accepted" => "Принят",
    "rejected" => "Отклонено",
    "new"      => "Новая",
    "reviewed" => "Рассмотрена"
  }.freeze

  def nav_link(name, path)
    link_to name, path, class: ("is-active" if current_page?(path))
  end

  def avatar(user, color: :auto, link: true)
    variant = color == :auto ? [ nil, "olive", "coral" ][user.id.to_i % 3] : color
    css = [ "avatar", ("avatar--#{variant}" if variant) ].compact.join(" ")
    letter = user.name.to_s.first.upcase

    if link
      link_to letter, user_path(user), class: css, title: user.name
    else
      tag.span letter, class: css, title: user.name
    end
  end

  def residents_block(listing)
    tag.div(class: "residents") do
      avatars = listing.residents.map { |user| avatar(user, link: false) }
      free = Array.new([ listing.free_spots, 4 ].min) { tag.span(plus_icon, class: "avatar avatar--free", title: "Свободное место") }
      caption = listing.free_spots.positive? ? "ищут ещё #{listing.free_spots}" : "мест нет"

      tag.div(safe_join(avatars + free), class: "avatars") +
        tag.span("#{listing.residents.size} из #{listing.max_people}, #{caption}", class: "muted")
    end
  end

  def heart_icon
    raw <<~SVG
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linejoin="round" aria-hidden="true"><path d="M12 20s-7-4.4-7-10a4 4 0 0 1 7-2.6A4 4 0 0 1 19 10c0 5.6-7 10-7 10z"/></svg>
    SVG
  end

  def plus_icon
    raw <<~SVG
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M12 6v12M6 12h12"/></svg>
    SVG
  end

  def compatibility_for(listing)
    return unless logged_in? && current_user != listing.user

    result = Compatibility.new(current_user, listing.user, listing)
    result if result.available?
  end

  def residents_text(listing)
    names = listing.residents.map(&:name).join(", ")
    free = listing.free_spots.positive? ? "свободно мест: #{listing.free_spots}" : "мест нет"
    "#{names} (#{listing.residents.size} из #{listing.max_people}, #{free})"
  end

  def listing_status_text(listing)
    return "Срок истёк" if listing.status == "active" && !listing.currently_active?

    status_label(listing.status)
  end

  def status_label(status)
    STATUS_LABELS.fetch(status.to_s, status)
  end

  def yes_no(value)
    value ? "да" : "нет"
  end

  def active_period(listing)
    return "бессрочно" if listing.active_until.blank?

    date = listing.active_until.strftime("%d.%m.%Y")
    listing.active_until < Date.current ? "срок истёк #{date}" : "до #{date}"
  end

  def rub(amount)
    return "—" if amount.blank?
    "#{number_with_delimiter(amount, delimiter: ' ')} ₽"
  end
end
