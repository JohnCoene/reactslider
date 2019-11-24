import { reactShinyInput } from 'reactR';
import {SingleSlider} from 'react-slider-kit';

const RangeInput = ({ configuration, value, setValue }) => {

  return (
    <div style={{width: configuration.chartLength + 'px'}}>
      <SingleSlider
        min={configuration.min}
        max={configuration.max}
        step={configuration.step}
        start={configuration.start}
        chartData={configuration.chartData}
        chartTooltip={configuration.chartTooltip}
        chartLength={configuration.chartLength}
        tooltip={configuration.tooltip}
        prefix={configuration.prefix}
        postfix={configuration.postfix}
        onChangeStart={() => console.log('start drag')}
        onChange={(value)=>console.log('drag value: ', value)}
        onChangeComplete={value => setValue(value)}
      />
    </div>
  )
};

reactShinyInput('.reactslider', 'reactslider.reactslider', RangeInput);