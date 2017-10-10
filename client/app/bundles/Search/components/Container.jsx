import React        from 'react';
import PropTypes    from 'prop-types';
import Input        from './Input.jsx';
import Filters      from './Filters.jsx';

export default class Container extends React.Component {
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
      <div className='search-container'>
        <div className='search-input-container'>
          <Input/>
        </div>
        <div className='search-filters-container'>
          <Filters/>
        </div>
      </div>
    );
  }

  componentDidMount() {
    console.log('search Container component is rendered')
  }
}
