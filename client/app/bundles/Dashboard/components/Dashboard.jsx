import PropTypes from 'prop-types';
import React from 'react';

export default class Dashboard extends React.Component {
  static propTypes = {
    records: PropTypes.array.isRequired,
  };

  /**
   * @param props - Comes from your rails view.
   * @param _railsContext - Comes from React on Rails
   */
  constructor(props, _railsContext) {
    super(props);
    this.state = {
      records: this.props.records
    };
  }

  render() {
    return (
      <div>
        <h3>
          Welcome to your dashboard!
        </h3>
        <hr />

      </div>
    );
  }

  componentDidMount() {
    console.log('dashboard component is rendered')
  }
}
