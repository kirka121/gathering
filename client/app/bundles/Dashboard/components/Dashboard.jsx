import React        from 'react';
import PropTypes    from 'prop-types';
import CardsList    from './CardsList.jsx';
import Search  from '../../Search/components/Container.jsx';

export default class Dashboard extends React.Component {
  static propTypes = {
    cards: PropTypes.array.isRequired,
  };

  /**
   * @param props - Comes from your rails view.
   * @param _railsContext - Comes from React on Rails
   */
  constructor(props, _railsContext) {
    super(props);

    this.state = {
      cards: this.props.records
    };
  }

  render() {
    return (
      <div>
        <h3>
          Welcome to your dashboard!
        </h3>
        <hr />

        <Search/>

        <CardsList cards={this.props.cards}/>
      </div>
    );
  }

  componentDidMount() {
    console.log('dashboard component is rendered')
  }
}
