# Ensure PROMPT_SUBST is enabled. This is crucial for $(...) in PROMPT.
setopt PROMPT_SUBST

# Load vcs_info
autoload -Uz vcs_info

# --- VCS_INFO Configuration ---
# Enable checking for git
zstyle ':vcs_info:*' enable git

# Format for git branch information. The leading space is useful.
zstyle ':vcs_info:git:*' formats ' [%b]'
# Format for when in the middle of an action (e.g., rebase, merge)
zstyle ':vcs_info:git:*' actionformats ' [%b|%a]'
# CRITICAL: Set the "no VCS" message to an empty string.
# This makes checking if vcs_info_msg_0_ is empty reliable.
zstyle ':vcs_info:*' nvcsformats ''

# --- Color Definitions ---
PROMPT_USER_COLOR="%F{green}"   # %F{colorname_or_number} for foreground
PROMPT_DIR_COLOR="%F{blue}"
PROMPT_GIT_COLOR="%F{red}"
PROMPT_RESET_COLOR="%f"         # %f to reset foreground color

# --- precmd: Executed before each prompt ---
precmd() {
  # Update vcs_info. The default context will populate vcs_info_msg_0_
  vcs_info
}

# --- Helper function for Git Prompt Segment ---
_zsh_prompt_git_segment() {
  # Check if vcs_info_msg_0_ (populated by vcs_info in precmd) is non-empty
  if [[ -n "$vcs_info_msg_0_" ]]; then
    # If there's git info, print it with its colors
    # echo -n is important to avoid a trailing newline
    echo -n "${PROMPT_GIT_COLOR}${vcs_info_msg_0_}${PROMPT_RESET_COLOR}"
  fi
  # If vcs_info_msg_0_ is empty, this function outputs nothing.
}

# --- Construct the PROMPT string ---
PROMPT=""
# User part: [user]
PROMPT+="${PROMPT_USER_COLOR}[%n]${PROMPT_RESET_COLOR}"
# Directory part: current_folder_basename
PROMPT+="${PROMPT_DIR_COLOR} %1~${PROMPT_RESET_COLOR}"
# Git part: $(_zsh_prompt_git_segment)
# This calls our function. PROMPT_SUBST ensures $(...) is executed.
PROMPT+='$(_zsh_prompt_git_segment)'
# Prompt symbol: % (or # for root)
PROMPT+=' : '

# Optional: Clean up global color variables if you prefer, though often they are kept.
# unset PROMPT_USER_COLOR PROMPT_DIR_COLOR PROMPT_GIT_COLOR PROMPT_RESET_COLOR
