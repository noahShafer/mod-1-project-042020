class PromptView
    attr_reader :model, :choice_str, :type, :top_line
    def initialize(model, choice_str, type, top_line)
        @model = model
        @choice_str = choice_str
        @type = type == nil ? "default" : type
        @top_line = top_line
    end

    def view_str
        if type == "default"
            choice_str
        elsif type == "user"
            str = ""
            str += "-----------------------------------------------\n".colorize(:color => :cyan) if top_line
            str += AsciiArt.new(model.profile_pic).to_ascii_art(width: 5) + " #{model.display_name}\n".bold 
            str += "  @#{model.username}\n".colorize( :color => :light_black)
            str += "  -----------------------------------------------".colorize(:color => :cyan) 
            str
        end
    end
end