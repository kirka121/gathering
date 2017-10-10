import React        from 'react';
import PropTypes    from 'prop-types';

export default class Input extends React.Component {
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
      <input type='text' name='search_query' className='form-control'/>
    );
  }

  componentDidMount() {
    console.log('search input component is rendered')
  }
}
