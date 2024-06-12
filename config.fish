#function fish_prompt
   # Prompt status only if it's not 0
set -l last_status $status
   set -l stat
   if test $last_status -ne 0
      set stat (set_color red)"[$last_status]"(set_color normal)
   end 
function fish_prompt
   string join '' -- (set_color green) (prompt_pwd --full-length-dirs 2) (set_color normal) $stat '>'
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    fastfetch
end
