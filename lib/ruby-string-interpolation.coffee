{CompositeDisposable} = require 'atom'

module.exports =
  activate: (state) ->
      @subscriptions = new CompositeDisposable
      @subscriptions.add atom.commands.add 'atom-workspace', 'ruby-string-interpolation:insert', => @insert()

  insert: ->
    editor = atom.workspace.getActiveTextEditor()
    if editor.getLastCursor().getScopeDescriptor().getScopesArray().indexOf("string.quoted.double.interpolated.ruby") != -1
      for selection in editor.getSelections()
          selection.insertText("\#{#{selection.getText()}}")
          if selection.getText().length == 0
              editor.getLastCursor().moveLeft()
    else
      editor.insertText('#')
