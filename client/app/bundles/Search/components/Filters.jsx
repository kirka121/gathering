import React        from 'react';
import PropTypes    from 'prop-types';

export default class Filters extends React.Component {
  static propTypes = {

  };

  /**
   * @param props - Comes from your rails view.
   * @param _railsContext - Comes from React on Rails
   */
  constructor(props, _railsContext) {
    super(props);

    // this.state = {
    //   cards: this.props.records
    // };
  }

  render() {
    return (
      <div className='search-filters-container'>
        placeholder for search filters
      </div>
    );
  }

  componentDidMount() {
    console.log('search input component is rendered')
  }
}
