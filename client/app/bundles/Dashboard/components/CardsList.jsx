import React            from 'react';
import PropTypes        from 'prop-types';
import CardLineItem     from './CardLineItem.jsx';

export default class CardsList extends React.Component {
  static propTypes = {
    cards: PropTypes.array.isRequired,
  };

  static contextTypes = {

  };

  constructor(props, _railsContext) {
    super(props);

    this.state = {
      cards: props.cards
    };
  }

  componentDidMount() {
    console.log('finsihed rendering CardsList');
  }

  componentWillUnmount(){
    console.log('about to unrender CardsList');
  }

  render() {
    return (
      <div className='cards-container'>
        {

            this.props.cards.map((card) =>
              <CardLineItem card={card} key={card._id}/>
            )

        }
      </div>
    );
  }
}
