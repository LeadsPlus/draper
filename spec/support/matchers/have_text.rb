module HaveTextMatcher
  def have_text(text)
    HaveText.new(text)
  end

  class HaveText
    def initialize(text)
      @text = text
    end

    def in(css)
      @css = css
      self
    end

    def matches?(subject)
      @subject = subject

      @subject.has_css?(@css || "*", text: @text)
    end

    def failure_message_for_should
      "expected to find #{@text.inspect} #{within}"
    end

    def failure_message_for_should_not
      "expected not to find #{@text.inspect} #{within}"
    end

    private

    def within
      "#{inside} within\n#{@subject.html}"
    end

    def inside
      @css ? "inside #{@css.inspect}" : "anywhere"
    end
  end
end

RSpec.configure do |config|
  config.include HaveTextMatcher
end
