AtomYafView = require './atom-yaf-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomYaf =
  atomYafView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomYafView = new AtomYafView(state.atomYafViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomYafView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-yaf:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomYafView.destroy()

  serialize: ->
    atomYafViewState: @atomYafView.serialize()

  toggle: ->
    console.log 'AtomYaf was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
