require 'json'

def get_timers
  items = Dir['timer_*.txt'].map do |file|
    remainder = File.read(file)
    
    remaining_seconds = remainder.split(':').reverse.map(&:to_i).each_with_index.sum { |val, idx| val * (60**idx) }

    end_time = Time.now + remaining_seconds
    end_time_str = end_time.strftime('%H:%M')

    {
      uid: file,
      valid: false,
      title: "#{remainder} left",
      subtitle: "Timer with #{remainder} left, ⌘+⏎ to remove. Ends at ~#{end_time_str}.",
      text: {
        copy: remainder,
        largetype: "#{remainder} seconds left! Ends at #{end_time_str}."
      },
      mods: {
        cmd: {
          arg: file,
          valid: true,
          subtitle: "Remove timer with #{remainder} left"
        }
      }
    }
  end

  { items: items }.to_json
end
