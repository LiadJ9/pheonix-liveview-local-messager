let ClockHook = {
  mounted() {
    const updateTime = () => {
      this.el.innerText = new Date().toLocaleTimeString();
    };

    updateTime();

    const now = new Date();
    const msToNextSecond = 1000 - now.getMilliseconds();

    setTimeout(() => {
      updateTime();
      this.timer = setInterval(updateTime, 1000);
    }, msToNextSecond);
  },

  destroyed() {
    clearInterval(this.timer);
  },
};

export default ClockHook;
