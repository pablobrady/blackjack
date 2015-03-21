class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<div style="width:120px;height:167px;background-image: url(\'img/cards/<%= rankName %>-<%= suitName %>.png\')" >'

  initialize: -> @render()

  render: ->
    @$el.children().empty()
    @$el.html @template @model.attributes
    @renderCovered() unless @model.get 'revealed'

  renderCovered: ->
    @$el.html("<img style=width:120px;height:167px; src=img/card-back.png >")
    console.log("renderCovered!")
