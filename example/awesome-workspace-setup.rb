# awesome
def mod(c) keypress :Mod, c; end # modifier combo keys
def tag(n) mod n; end # switch to tag
def run(app, tag = nil) # use awesome keys to run a cmd
  mod tag if tag
  mod :r
  type app
  keypress :Enter
  wait
end
def terminal(cmd=nil)
  if cmd then
    run "gnome-terminal #{cmd}"
    wait 2 # extra for cmd to run
  else
    keypress :Mod, :Enter
  end
  wait 2
end

# vbox
def startvm(name, tag=nil) run %Q(VBoxManage startvm "#{name}"), tag; wait; end

# vi
def vi_find(s) enter "/#{s}"; end
def vi_normal; keypress :Esc; keypress ':'; keypress :Esc; end
def open_nerdtree; keypress :Ctrl, :e; end
def toggle_nerdtree_bookmarks; keypress :Shift, :b; end
def gvim_open_project(project, subdir=nil)
  run :gvim
  wait # for launch
  open_nerdtree
  toggle_nerdtree_bookmarks # open
  vi_find project; enter # open project dir
  toggle_nerdtree_bookmarks # closed
  if subdir
    vi_find 'src'; enter # move to ./src/
  end
  type 'cd'
  keypress :Shift, :c # make ./src/ new project root
  vi_find '``'
  vi_normal
end


# actual script
# debug true

def step1
  tag 9
  startvm 'VM-2 Cake CMS'
  startvm 'VM-3 Rails CMS'
end
step1

def step2
  tag 3

  gvim_open_project 'lnroot', 'src' # Rails.SCMS

  3.times { keypress :Mod, :Space } # switch to awesome tile.bottom layout

  # 2: compass watch
  enter ':Terminal'; wait 2
  enter 'compass watch'
  keypress :Mod, :Shift, :Tab; wait # focus gvim

  # 1: rails console
  keypress ':'; keypress 'Up'; enter
  enter 'ssh rails.cms'
  enter 'rails c'
  keypress :Mod, :Shift, :Tab; wait # focus gvim

  # 3: ssh rails.cms
  keypress ':'; keypress 'Up'; enter
  enter 'ssh rails.cms'
  keypress :Mod, :Shift, :Tab; wait # focus gvim

  keypress :Mod, :Shift, :j; wait # move gvim up
end
step2

def step3
  tag 2
  gvim_open_project 'Cake.SCMS'

  3.times { keypress :Mod, :Space } # switch to awesome tile.bottom layout

  # 2: php -a
  enter ':Terminal'; wait 2
  enter 'php -a'
  keypress :Mod, :Shift, :Tab; wait # focus gvim

  # 1: git log
  keypress ':'; keypress 'Up'; enter
  enter 'git log'
  keypress :Mod, :Shift, :Tab; wait # focus gvim

  keypress :Mod, :Shift, :j; wait # move gvim up
end
step3

def step4
  keypress :Ctrl, :Mod, :Right # switch screens
  tag 3

  # webrick
  terminal
  enter 'ssh rails.cms'
  enter 'rails s --debugger'

  # pgsql log
  terminal
  enter 'ssh rails.cms'
  enter 'sudo tail -f /var/log/postgresql/postgresql-8.4-main.log'

  keypress :Mod, :b # launch browser
  wait 4
  keypress :Alt, :d # select address bar
  enter 'http://rails.cms.local:3000'
  wait 4

  3.times { keypress :Mod, :Space } # switch to awesome tile.bottom layout
end
step4

def step5
  tag 2

  # apache log
  terminal
  enter 'ssh cake.cms'
  enter 'sudo tail -f /var/log/apache2/*.log'

  # pgsql log
  terminal
  enter 'ssh cake.cms'
  enter 'sudo tail -f /var/log/postgresql/postgresql-8.4-main.log'

  keypress :Mod, :b # launch browser
  wait 4
  keypress :Alt, :d # select address bar
  enter 'http://cake.cms.local/users/login'
  wait 4
  3.times { keypress :Tab }; enter # login

  3.times { keypress :Mod, :Space } # switch to awesome tile.bottom layout
end
step5

def step6
  tag 4
  run 'pgadmin3'
  wait 4
end
step6

keypress :Ctrl, :Mod, :Right # switch screens
tag 1 # done
